package com.et.booking;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;
import com.et.reservation.Condition;
import com.et.reservation.Seat;
import com.et.reservation.Train;

@Service("booking.bookingService")
public class BookingServiceImpl implements BookingService{
	
	@Autowired
	private CommonDAO dao;

	@Override
	public int insertReservation(Booking dto) throws Exception {
		int prCode=0;
		int seq = 0;
		String reservationNumber = null;
		try {
			
			reservationNumber = dao.selectOne("booking.reservationNumber");
			dto.setReservationNumber(reservationNumber);
			
			seq = dao.selectOne("booking.setPrcode");
			dto.setPrSeq(seq);
			dao.updateData("booking.updateStock", dto);
			prCode = dao.selectOne("booking.setPrcode1");
			dto.setPrCode(prCode);
				dao.insertData("booking.insertReservation", dto);
				dao.updateData("booking.updatePayDate", dto.getPrSeq());
				reservationTrain(dto);
				if(dto.getRoomGrade().equals("일반")) {
					dto.setPrAddPrice(0);
					dao.insertData("booking.insertTrain", dto);	
				} else {
					dto.setPrAddPrice(dto.getPrAddPrice()*dto.getPrPersonnel());
					dao.insertData("booking.insertTrain", dto);
				}
				prCode = dao.selectOne("booking.setPrcode1");
				dto.setPrCode(prCode);
				dao.insertData("booking.insertReservation1", dto);
				dao.updateData("booking.updatePayDate", dto.getPrSeq());
				reservationTrain1(dto);
				if(dto.getRoomGrade1().equals("일반")) {
					dto.setPrAddPrice1(0);
					dao.insertData("booking.insertTrain1", dto);
				} else {
					dto.setPrAddPrice1(dto.getPrAddPrice1()*dto.getPrPersonnel());
					dao.insertData("booking.insertTrain1", dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return seq;
	}

	@Override
	public List<Booking> readPromotionDetail(Map<String, Object> map) {
		List<Booking> list = null;
		try {
			list = dao.selectList("booking.readTravel", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteReservation(Map<String, Object> map) throws Exception {
		try {
			List<Booking> list = readForCancle(map);
			for(Booking dto : list) {
				if(Integer.parseInt(dto.getTrainCode())%2==0) {
					dao.deleteData("booking.deleteReservation", dto);
					dao.updateData("booking.updateStock1", dto);
					dao.deleteData("booking.deleteTrain", dto.getPrCode());
				} else {
					dao.deleteData("booking.deleteReservation", dto);
					dao.deleteData("booking.deleteTrain", dto.getPrCode());
				}
				dao.deleteData("booking.deleteTrain", dto.getPrCode());
				dao.updateData("booking.reFundUpdate", dto.getTrCode());
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	public void deleteAdmin(int prSeq) throws Exception {
		try {
			List<Booking> list = adminCancle(prSeq);
			for(Booking dto : list) {
				if(Integer.parseInt(dto.getTrainCode())%2==0) {
					dao.deleteData("booking.deleteReservationAdmin", prSeq);
					dao.updateData("booking.updateStock1", dto);
				} else {
					dao.deleteData("booking.deleteReservationAdmin", prSeq);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Booking> listReservation(Map<String, Object> map) {
		List<Booking> list = null;
		try {
			list = dao.selectList("booking.listReservation",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Booking> readReservation(Map<String, Object> map) {
		List<Booking> list = null;
		try {
			list = dao.selectList("booking.readReservation", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public String readPromotionImage(int prSeq) {
		String saveFileName = "";
			try {
				saveFileName = dao.selectOne("booking.readPromotionImage", prSeq);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return saveFileName;
	}

	@Override
	public Booking readCrew(Map<String, Object> map) {
		Booking dto = null;
		try {
			dto=dao.selectOne("booking.readCrew", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Booking readTrian(Map<String, Object> map) {
		Booking dto = null;
		try {
			dto = dao.selectOne("booking.readTrain", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Booking readtrainlist(Booking dto) {
		Booking start = null;
		try {
			start = dao.selectOne("booking.trainRead", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return start;
	}

	@Override
	public Seat readSeat(Map<String, String> map) {
		Seat dto = null;
		try {
			dto = dao.selectOne("booking.readSaet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<Seat> listSeat(String trainCategory) {
		List<Seat> list = null;
		try {
			list = dao.selectList("booking.listSeat", trainCategory);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int readsPay(Booking dto) {
		int result = 0;
		try {
			dto.setStartCode(dao.selectOne("booking.readStationCode", dto));
			dto.setEndCode(dao.selectOne("booking.readStationCode1", dto));
			result = dao.selectOne("booking.readsPay", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int readsPay1(Booking dto) {
		int result = 0;
		try {
			dto.setEndCode(dao.selectOne("booking.readStationCode", dto));
			dto.setStartCode(dao.selectOne("booking.readStationCode1", dto));
			result = dao.selectOne("booking.readsPay1", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Train> listTrain(Condition dto) {
		List<Train> list=new ArrayList<>();
		try {
			//하행인지 상행인지 가져오기. 리스트는 하행기준으로 역이름을 가져오므로 
				//넘겨준 출발역이 리스트의 첫번째역과 같으면 하행, 같지 않으면 상행
			List<String> route=dao.selectList("booking.searchRoute", dto); //
			if(route.get(0).equals(dto.getStartSt())) {
				dto.setRoute(1);  //기차코드가 홀수이면 하행이고 짝수이면 상행이다.
			}else {
				dto.setRoute(0);
			}
			String originalnameSt=dto.getStartSt();
			String originalnameEnd=dto.getEndSt();
			
			//영어역이름 가져오기
			Map<String, String> stmap=new HashMap<>();  //쿼리결과 가져와서 담는 맵
			
			String station=dto.getStartSt();
			stmap=dao.selectOne("booking.readStation",station);
			String startSt=stmap.get("ENGNAME");
			
			station=dto.getEndSt();
			stmap=dao.selectOne("booking.readStation",station);
			String endSt=stmap.get("ENGNAME");
			
			dto.setStartSt(startSt);
			dto.setEndSt(endSt);
			list=dao.selectList("booking.listTrain", dto);
			for(Train tr:list) {
				tr.setDepartureSt(originalnameSt);
				tr.setArriveSt(originalnameEnd);
			}
			dto.setStartSt(originalnameSt);
			dto.setEndSt(originalnameEnd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public String totalTime(Train dto) {
		String totalTime="";
		try {
			int time=dao.selectOne("booking.totalTime", dto);
			String h=(time/60)<10?"0"+Integer.toString(time/60):Integer.toString(time/60);
			String m=(time%60)<10?"0"+Integer.toString(time%60):Integer.toString(time%60);
			totalTime=h+":"+m;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalTime;
	}

	@Override
	public List<Booking> readForCancle(Map<String, Object> map) {
		List<Booking> list = null;
		try {
			list = dao.selectList("booking.readForCancle", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<Booking> adminCancle(int prSeq) {
		List<Booking> list = null;
		try {
			list = dao.selectList("booking.deleteReservationAdmin", prSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public String readStartStation(String Station) {
		String startStation = null;
		try {
			startStation = dao.selectOne("booking.getKoreaStart", Station);
		} catch (Exception e) {
		}
		return startStation;
	}

	@Override
	public String readEndStation(String Station) {
		String endStation = null;
		try {
			endStation = dao.selectOne("booking.getKoreaEnd", Station);
		} catch (Exception e) {
		}
		return endStation;
	}

	@Override
	public int reservationCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("booking.reservationCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public void paymentSuccess(int prSeq) {
		try {
			dao.updateData("booking.updatePrPayment", prSeq);
		} catch (Exception e) {
		}
	}

	@Override
	public void reservationTrain(Booking dto) throws Exception {
		int trCode = 0;
		try {
			trCode=dao.selectOne("booking.trainreservationSeq");
			dto.setTrCode(trCode);
			dto.setStartStation(dao.selectOne("booking.getEngStart", dto.getStartStation()));
			dto.setEndStation(dao.selectOne("booking.getEngEnd", dto.getEndStation()));
			dto.setStartCode(dao.selectOne("booking.readStationCode", dto));
			dto.setEndCode(dao.selectOne("booking.readStationCode1", dto));
			if(dto.getRoomGrade().equals("일반")) {
				dto.setPrAddPrice(0);
				dao.insertData("booking.reservationTrain", dto);
			} else {
				dao.insertData("booking.reservationTrain", dto);
			}
			dao.insertData("booking.insertReservationInfo", dto);
			
			int rsSeatCode = 0;
			if(!dto.getPrStartTrainSeat().contains(",")) {
				dto.setSeatNum(dto.getPrStartTrainSeat());
				rsSeatCode = dao.selectOne("booking.reservedSeatSeq");
				dto.setRsSeatCode(rsSeatCode);
				int seatType[] = {dto.getAdult(), dto.getChild(), dto.getOldMan()};
				for(int a=0;a<seatType.length;a++) {
					for(int b=0;b<seatType[a];b++) {
						String name="";
						switch (a) {
							case 0: name="성인"; break;
							case 1: name="어린이"; break;
							case 2: name="경로"; break;
						}
						dto.setSeatType(name);
						dao.insertData("booking.insertReservedSeat", dto);
					}
				}
			} else {
				String[] seatNum = dto.getPrStartTrainSeat().split(",");
				int price = dto.getPrAddPrice();
				for(int i=0;i<seatNum.length;i++) {
					int seatType[] = {dto.getAdult(), dto.getChild(), dto.getOldMan()};
						String name = "";
						String type = "";
						for(int a=0;a<seatType.length;a++) {
							for(int b=0;b<seatType[a];b++) {
								switch (a) {
									case 0: name="성인"; break;
									case 1: name="어린이"; break;
									case 2: name="경로"; break;
								}
								type +=","+name;
							}
						}
						String seat[] = type.split(",");
						dto.setSeatNum(seatNum[i]);
						dto.setSeatType(seat[i+1]);
						rsSeatCode = dao.selectOne("booking.reservedSeatSeq");
						dto.setRsSeatCode(rsSeatCode);
						dto.setPrAddPrice(price/dto.getPrPersonnel());
						dao.insertData("booking.insertReservedSeat", dto);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public void reservationTrain1(Booking dto) throws Exception{
		int trCode = 0;
		try {
			trCode=dao.selectOne("booking.trainreservationSeq");
			dto.setTrCode(trCode);
			dto.setStartStation1(dao.selectOne("booking.getEngStart1", dto.getStartStation1()));
			dto.setEndStation1(dao.selectOne("booking.getEngEnd1", dto.getEndStation1()));
			dto.setStartCode(dao.selectOne("booking.readStationCode", dto));
			dto.setEndCode(dao.selectOne("booking.readStationCode1", dto));
			if(dto.getRoomGrade1().equals("일반")) {
				dto.setPrAddPrice1(0);
				dao.insertData("booking.reservationTrain1", dto);
			} else {
				dao.insertData("booking.reservationTrain1", dto);
			}
			dao.insertData("booking.insertReservationInfo1", dto);
			
			int rsSeatCode = 0;
			if(!dto.getPrEndTrainSeat().contains(",")) {
				dto.setSeatNum(dto.getPrEndTrainSeat());
				rsSeatCode = dao.selectOne("booking.reservedSeatSeq");
				dto.setRsSeatCode(rsSeatCode);
				int seatType[] = {dto.getAdult1(), dto.getChild1(), dto.getOldMan1()};
				for(int a=0;a<seatType.length;a++) {
					for(int b=0;b<seatType[a];b++) {
						String name="";
						switch (a) {
							case 0: name="성인"; break;
							case 1: name="어린이"; break;
							case 2: name="경로"; break;
						}
						dto.setSeatType(name);
						dao.insertData("booking.insertReservedSeat1", dto);
					}
				}
			} else {
				String[] seatNum = dto.getPrStartTrainSeat().split(",");
				int price = dto.getPrAddPrice1();
				for(int i=0;i<seatNum.length;i++) {
					int seatType[] = {dto.getAdult1(), dto.getChild1(), dto.getOldMan1()};
						String name="";
						String type = "";
						for(int a=0;a<seatType.length;a++) {
							for(int b=0;b<seatType[a];b++) {
								switch (a) {
									case 0: name="성인"; break;
									case 1: name="어린이"; break;
									case 2: name="경로"; break;
								}
								type+=","+name;
							}
						}
						String seat[] = type.split(",");
						dto.setSeatNum(seatNum[i]);
						dto.setSeatType(seat[i+1]);
						rsSeatCode = dao.selectOne("booking.reservedSeatSeq");
						dto.setRsSeatCode(rsSeatCode);
						dto.setPrAddPrice1(price/dto.getPrPersonnel());
						dao.insertData("booking.insertReservedSeat1", dto);
					}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Booking> readDetail2(String crewId) {
		List<Booking> list2 = null;
		
		try {
			list2 = dao.selectList("booking.listReservation2", crewId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list2;
	}

	@Override
	public List<Booking> listmyPromotionList(String crewId) {
		List<Booking> list = null;
		try {
			list = dao.selectList("booking.myPromotionList", crewId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
}

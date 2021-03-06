package com.et.booking;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.crew.SessionInfo;
import com.et.reservation.ReservationService;
import com.et.reservation.ReservedSeat;
import com.et.reservation.Seat;

@Controller("booking.bookingController")
@RequestMapping("/booking/*")
public class BookingController {
	
	@Autowired
	private BookingService service;

	@Autowired
	private ReservationService service1;
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "reservation", method = RequestMethod.GET)
	public String reservation(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) {

		List<Booking> list = service.readPromotionDetail(paramMap);
		List<Booking> list1 = service.readPromotionDetail(paramMap);
		Booking startDto = null, endDto = null;
		Booking start = null, end = null;
		for (Booking dto : list) {
			if (Integer.parseInt(dto.getTrainCode()) % 2 != 0) {
				startDto = dto;
			} else {
				endDto = dto;
			}
		}
		for (Booking vo : list1) {
			if (Integer.parseInt(vo.getTrainCode()) % 2 != 0) {
				start = vo;
				start = service.readtrainlist(start);
				start.setPrAddPrice(service.readsPay(start));
			} else {
				end = vo;
				end = service.readtrainlist(end);
				end.setPrAddPrice1(service.readsPay1(end));
			}
		}
		startDto.setStartStation(service.readStartStation(startDto.getStartStation()));
		startDto.setEndStation(service.readEndStation(startDto.getEndStation()));
		endDto.setStartStation(service.readStartStation(endDto.getStartStation()));
		endDto.setEndStation(service.readEndStation(endDto.getEndStation()));

		SessionInfo info = (SessionInfo) session.getAttribute("crew");

		Map<String, Object> map = new HashMap<>();
		map.put("crewId", info.getCrewId());
		Booking dto = service.readCrew(map);

		String s = (String) paramMap.get("pmStartDate");
		String sDate = "", pmEndDate="";
		String eDate = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/M/d(E)");

			Date date = sdf.parse(s);
			sDate = sdf2.format(date);
			
			date.setDate(date.getDate()+1);
			
			pmEndDate = sdf.format(date);
			eDate = sdf2.format(date);
		} catch (Exception e) {
		}
		

		model.addAttribute("mode", "reservation");
		model.addAttribute("startDto", startDto);
		model.addAttribute("endDto", endDto);
		model.addAttribute("pmEndDate", pmEndDate);
		model.addAttribute("pmStartDate", paramMap.get("pmStartDate"));
		model.addAttribute("pmStartDate1", sDate);
		model.addAttribute("pmStartDate2", eDate);
		model.addAttribute("prPersonnel", paramMap.get("prPersonnel"));
		model.addAttribute("dto", dto);
		model.addAttribute("start", start);
		model.addAttribute("end", end);

		return ".booking.reservation";
	}

	@RequestMapping(value = "reservation", method = RequestMethod.POST)
	public String reservationSubmit(
			Booking dto, 
			HttpSession session
			) {
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		int prSeq = 0;
		try {
			dto.setCrewId(info.getCrewId());
			prSeq = service.insertReservation(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/booking/receipt?prSeq=" + prSeq;
	}

	@RequestMapping(value = "receipt") // ?????????
	public String receipt(@RequestParam int prSeq, HttpSession session, Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		Map<String, Object> map = new HashMap<>();
		map.put("prSeq", prSeq);
		map.put("crewId", info.getCrewId());
		try {

			List<Booking> list = service.readReservation(map);
			List<Booking> list1 = service.readReservation(map);
			Booking startDto = null, endDto = null;
			Booking start = null, end = null;
			for (Booking dto : list) {
				if (Integer.parseInt(dto.getTrainCode()) % 2 != 0) {
					startDto = dto;
				} else {
					endDto = dto;
				}
			}
			for (Booking vo : list1) {
				if (Integer.parseInt(vo.getTrainCode()) % 2 != 0) {
					start = vo;
					start = service.readtrainlist(start);
					start.setPrAddPrice(service.readsPay(start));
				} else {
					end = vo;
					end = service.readtrainlist(end);
					end.setPrAddPrice1(service.readsPay1(end));
				}
			}

			startDto.setStartStation(service.readStartStation(startDto.getStartStation()));
			startDto.setEndStation(service.readEndStation(startDto.getEndStation()));
			endDto.setStartStation(service.readStartStation(endDto.getStartStation()));
			endDto.setEndStation(service.readEndStation(endDto.getEndStation()));

			model.addAttribute("prSeq", prSeq);
			model.addAttribute("startDto", startDto);
			model.addAttribute("endDto", endDto);
			model.addAttribute("start", start);
			model.addAttribute("end", end);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".booking.receipt";
	}

	@RequestMapping(value = "paymentSuccess") // ?????????
	public String paymentForm(@RequestParam int prSeq, HttpSession session, Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		Map<String, Object> map = new HashMap<>();
		map.put("prSeq", prSeq);
		map.put("crewId", info.getCrewId());
		String saveFileName = "";
		saveFileName=service.readPromotionImage(prSeq);
		
		try {
			List<Booking> list = service.readReservation(map); 
			List<Booking> list1 = service.readReservation(map);
			Booking startDto = null, endDto = null;
			Booking start = null, end = null;
			for (Booking dto : list) {
				if (Integer.parseInt(dto.getTrainCode()) % 2 != 0) {
					startDto = dto;
				} else {
					endDto = dto;
				}
			}
			startDto.setStartStation(service.readStartStation(startDto.getStartStation()));
			startDto.setEndStation(service.readEndStation(startDto.getEndStation()));
			endDto.setStartStation(service.readStartStation(endDto.getStartStation()));
			endDto.setEndStation(service.readEndStation(endDto.getEndStation()));

			for (Booking vo : list1) {
				if (Integer.parseInt(vo.getTrainCode()) % 2 != 0) {
					start = vo;
					start = service.readtrainlist(start);
				} else {
					end = vo;
					end = service.readtrainlist(end);
				}
			}
			
			service.paymentSuccess(prSeq);

			model.addAttribute("saveFileName", saveFileName);
			model.addAttribute("startDto", startDto);
			model.addAttribute("endDto", endDto);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ".booking.paymentSuccess";
	}

	@RequestMapping(value = "delete")
	public String cancleReservation(@RequestParam int prSeq, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("crew");
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("crewId", info.getCrewId());
			map.put("prSeq", prSeq);
			service.deleteReservation(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/travel/main";
	}

	
	
	@RequestMapping("seat")
	public String seatForm(@RequestParam Map<String, String> map, Model model) {
		if (map.get("tCategory").equals("all")) {
			map.put("tCategory", "KTX"); // ????????????
		} else if (map.get("tCategory").equals("KTX")) {
			map.put("tCategory", "KTX");
		} else if (map.get("tCategory").equals("ITX")) {
			map.put("tCategory", "ITX");
		} else if (map.get("tCategory").equals("mugunghwa")) {
			map.put("tCategory", "mugunghwa");
		}
		Seat dto = new Seat();
		if (map.get("firstPage").equals("true")) {
			String roomFirst = service1.roomFirst(map);
			dto.setRoomNum(Integer.parseInt(roomFirst));
			map.put("roomNum", roomFirst);
		} else {
			dto.setRoomNum(Integer.parseInt(map.get("roomNum")));
		}
		dto = service1.readSeat(map);
		List<Seat> list = service1.listSeat(map);

		// ?????? ??????, ????????????, ???????????? ???????????? ????????? ?????? ???????????? ?????????.
		// (jsp????????? ????????? ????????? ?????? ??????????????? ????????? ????????? ?????????????????? ?????? ??????)
		map.put("seatColumn", Integer.toString(dto.getSeatColumn()));
		List<String> rvlist = service1.listReservedSeat(map);

		// ??????????????? ????????? ????????????
		List<Integer> fullSeatlist = service1.fullSeat(map);

		model.addAttribute("list", list);
		model.addAttribute("dto", dto);
		model.addAttribute("map", map);
		model.addAttribute("rvlist", rvlist); // ?????? ????????? ?????? ?????????
		model.addAttribute("fullSeatlist", fullSeatlist); // ???????????? ????????? ?????????
		return "booking/seat";
	}

	@RequestMapping("confirm")
	public String confirm(@RequestParam Map<String, String> map, Model model) {
		if (map.get("directRv").equals("true")) {
			if (map.get("tCategory").equals("all")) {
				map.put("tCategory", "KTX"); // ????????????
			} else if (map.get("tCategory").equals("KTX")) {
				map.put("tCategory", "KTX");
			} else if (map.get("tCategory").equals("ITX")) {
				map.put("tCategory", "ITX");
			} else if (map.get("tCategory").equals("mugunghwa")) {
				map.put("tCategory", "mugunghwa");
			}

			// ?????????
			String roomNum = service1.roomFirst(map);
			map.put("roomNum", roomNum);
			// ??????
			List<String> seatList = service1.unReservedSeat(map);
			int i = 1;
			for (String seat : seatList) {
				map.put("seatNum" + i, seat);
				i++;
			}
		}

		// ????????? list??? ????????????.
		List<ReservedSeat> seatList = new ArrayList<>();

		// ????????????
		int adult = Integer.parseInt(map.get("adult"));
		int child = Integer.parseInt(map.get("child"));
		int oldMan = Integer.parseInt(map.get("oldMan"));

		int seatType[] = { adult, child, oldMan };
		List<String> seatTypelist = new ArrayList<>();

		for (int i = 0; i < seatType.length; i++) {
			for (int j = 0; j < seatType[i]; j++) {
				String name = "";
				switch (i) {
				case 0:
					name = "??????";
					break;
				case 1:
					name = "?????????";
					break;
				case 2:
					name = "??????";
					break;
				}
				seatTypelist.add(name);
			}
		}


		model.addAttribute("map", map);
		model.addAttribute("seatList", seatList);
		return "/booking/reservation";
	}
	
	@RequestMapping("detail")
	public String detail(
			HttpSession session,
			HttpServletRequest req,
			Model model) {
	SessionInfo info = (SessionInfo) session.getAttribute("crew");
		try {
			
			// ????????????
			List<Booking> list = service.listmyPromotionList(info.getCrewId());
			for(Booking dto : list) {
			    dto.setPrReservationDate(dto.getPrReservationDate().substring(0, 10));
			    dto.setStartStation(service.readStartStation(dto.getStartStation()));
			    dto.setEndStation(service.readEndStation(dto.getEndStation()));
			}
			model.addAttribute("list",list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	return ".booking.detail";
	
	}
}

package com.et.train;

import java.util.List;

public class Train {
	private String trainCategory;				// 기차코드
	
	private List<Integer> roomNums;				// 칸 번호 리스트
	private int roomNum;						// 칸 번호
	private List<String> roomNames;				// 객실 등급 리스트
	private String roomGrade;					// 객실 등급
	
	private List<Integer> seatRows;				// 좌석 행 리스트
	private int seatRow;						// 좌석 행
	private List<Integer> seatColumns;			// 좌석 열 리스트
	private int seatColumn;						// 좌석 열
	private int trainSeatCount;					// 좌석 갯수
	private int trainRoomCount;					// 칸 갯수
	private int trainCount;
	private int trainSeq;
	
	
	public String gettrainCategory() {
		return trainCategory;
	}
	public void settrainCategory(String trainCategory) {
		this.trainCategory = trainCategory;
	}
	public List<Integer> getRoomNums() {
		return roomNums;
	}
	public void setRoomNums(List<Integer> roomNums) {
		this.roomNums = roomNums;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public List<String> getRoomNames() {
		return roomNames;
	}
	public void setRoomNames(List<String> roomNames) {
		this.roomNames = roomNames;
	}
	public String getRoomGrade() {
		return roomGrade;
	}
	public void setRoomGrade(String roomGrade) {
		this.roomGrade = roomGrade;
	}
	public List<Integer> getSeatRows() {
		return seatRows;
	}
	public void setSeatRows(List<Integer> seatRows) {
		this.seatRows = seatRows;
	}
	public int getSeatRow() {
		return seatRow;
	}
	public void setSeatRow(int seatRow) {
		this.seatRow = seatRow;
	}
	public List<Integer> getSeatColumns() {
		return seatColumns;
	}
	public void setSeatColumns(List<Integer> seatColumns) {
		this.seatColumns = seatColumns;
	}
	public int getSeatColumn() {
		return seatColumn;
	}
	public void setSeatColumn(int seatColumn) {
		this.seatColumn = seatColumn;
	}
	public int getTrainSeatCount() {
		return trainSeatCount;
	}
	public void setTrainSeatCount(int trainSeatCount) {
		this.trainSeatCount = trainSeatCount;
	}
	public int getTrainRoomCount() {
		return trainRoomCount;
	}
	public void setTrainRoomCount(int trainRoomCount) {
		this.trainRoomCount = trainRoomCount;
	}
	public int getTrainCount() {
		return trainCount;
	}
	public void setTrainCount(int trainCount) {
		this.trainCount = trainCount;
	}
	public int getTrainSeq() {
		return trainSeq;
	}
	public void setTrainSeq(int trainSeq) {
		this.trainSeq = trainSeq;
	}
	
	
	
	
}

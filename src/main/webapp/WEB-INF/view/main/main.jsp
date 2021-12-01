<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script type="text/javascript">
function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}


$(function(){
	var st="";
	var modal = document.getElementById("myModal");
	$(".myBtn").click(function(){
		var span = document.getElementsByClassName("close")[0];
		modal.style.display = "block";
		st=$(this).closest("div").children("input");
		
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
		  modal.style.display = "none";
		}
		
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		  if (event.target == modal) {
		    modal.style.display = "none";
		  }
		}
	});
	
	$(".stationBtn").click(function(){
		var sName=$(this).val();
		$(st).val(sName);
		modal.style.display = "none";
	});
});

$(function(){
	$("#directReservation").click(function(){
		var time=$("#time").val()
		if(time=="시간"){
			alert("시간을 선택해 주십시오.");
			return;
		}
		
		//열차종류=all, 인원정보=어른1
		var f=document.mainRvForm;
		f.submit();
	});
});

</script>

<style>
p.title1{
  color: #fff;
  font-weight: bold;
  font-size: 16px;
}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #44565B;
  margin: auto;
  padding: 10px;
  border: 1px solid #888;
  width: 400px;
  height: 500px;
}

.modal-content2 {
  background-color: #44565B;
  margin: auto;
  padding: 10px;
  border: 1px solid #888;
  width: 800px;
  height: 600px;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

</style>

<!-- The Modal -->
<div id="myModal" class="modal">
  <!-- Modal content -->
  <div style="background: #273267;" class="modal-content">
  	<div style="text-align:center;  margin-bottom: 10px;">
    <span  style="line-height:17px; font-size:17px; color: white; font-weight: bold;">노선선택</span><span class="close">&times;</span>
    </div>
	    <div style="padding:10px; height:90%; background: white;">
	    	<c:set var="i" value="0"/>
		    <table style="height:250px; width: 100%;">
		    	<tr>
		    		<c:forEach var="dto" items="${stationList}">
		    			<td style=" height:35px; padding:5px; width: 30%;">
		    				<button type="button" value="${dto.sName}" class="stationBtn" style="background:#e1e8e76e; border:1px solid #D5D5D5;  height:100%; width: 100%;">${dto.sName}</button></td>
		    			<c:set var="i" value="${i+1}"/>
		    			<c:if test="${i%3==0}">
		    				</tr>
		    				<tr>
		    			</c:if>
		    		</c:forEach>
		    	</tr>
		    </table>
	    </div>
  </div>
</div>

<!-- Main -->
<div id="page1" style="background: #f4f4f473;">
	<div style="background-position:center; background-size:cover; background-image:url('<%=cp%>/resource/images/trainbg.jpg'); width: 100%; height: 450px;">
		<form name="mainRvForm" method="post" action="<%=cp%>/reservation/main">
			<input type="hidden" name="directRv" value="true">
			<div style="padding: 100px; padding-top: 80px;">
				<div style="text-align: center;">
					<p style="font-size: 25px; font-weight: bold;">어디로 가고 싶으세요?</p>
				</div>
				<table class="mainreservation" style=" background-color: rgba(25, 25, 25, 0.8); margin:0 auto; width: 1200px; padding: 10px;">
					<tr>
						<td style="padding-top:20px; padding-left: 30px; font-size: 15px;">
							<label style="color: white;">출발지</label>
						</td>
						<td style="padding-top:20px; padding-left: 30px;">
							<label style="color: white;">도착지</label>
						</td>
						<td style="padding-top:20px; padding-left: 30px;">
							<label style="color: white;">출발날짜</label>
						</td>
						<td style="padding-top:20px; padding-left: 30px;">
							<label style="color: white;">출발시간</label>
						</td>
					</tr>
					<tr>
						<td style="width: 27%;padding-left: 30px;">
							<div>
								<input type="text" name="startSt" value="${firstSt}" id="startSt" style="width:70%; padding:5px; border: 1px solid #aaa; font-size: 15px; border-radius: 5px;">
								<button type="button" style="border:none; background: #273267; height: 40px; width: 40px;" class="myBtn">
									<i class="fas fa-map-marker-alt" style="padding:2.5px; padding-right:5px; padding-left:5px; margin:4px; font-size: 20px; color: white;"></i>
								</button>
							</div>
						</td>
						<td style="width: 27%; padding-left: 30px;">
							<div>
								<input type="text" name="endSt" value="${lastSt}" id="endSt" style="width:70%; padding:5px; border: 1px solid #aaa; font-size: 15px; border-radius: 5px;">
								<button type="button" style="border:none; background: #273267; height: 40px; width: 40px;" class="myBtn">
									<i class="fas fa-map-marker-alt" style="padding:2.5px; padding-right:5px; padding-left:5px; margin:4px; font-size: 20px; color: white;"></i>
								</button>
							</div>
						</td>
						<td style="width: 27%; padding-left: 30px;">
							<input type="text" min="${day}" max="${maxday}" name="day" onfocus="(this.type='date')" value="${day}" placeholder="예약날짜" style="border-radius: 5px; width:80%; padding:5px; font-size: 15px; border: 1px solid #aaa;">
						</td>
						<td style="width: 19%; padding-left: 30px;">
				        	<select  name="time" id="time" style="width:80%; border: 1px solid #aaa; font-size: 15px; padding: 5px; border-radius: 5px;">
								<option value="시간">시간</option>
								<c:forEach var="n" begin="0" end="22" step="2">
									<option>${n<10?"0":""}${n}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;">
							<button style="border:none; margin:25px; font-size: 20px;" type="button" id="directReservation" class="mainreservationbuttontd"><i class="fas fa-search"></i>&nbsp;&nbsp;간편조회하기 </button>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	
	<!-- Extra -->
	<div class="container" style="margin-top: 50px; margin-bottom:50px; height: 370px; width: 1200px;">
		<div style="float: left; width: 37%; margin-right: 20px; box-shadow: 0px 0px 10px #ddd; height: 100%; background: white;">
			<div class="mainnotice2" style="margin-top: 10px;">
				<div class="mainnoticeTitle">
					<b style="font-size: 18px;">Enjoy in Train 공지사항</b>
					<a href="<%=cp%>/notice/list" class="mainnoticebutton"> + 더보기 </a>
				</div>
				<div class="maintop1">
					<table class="mainnoticetable">
					<c:forEach var="dto" items="${list}">
						<tr class="mainnotice">
							<td class="mainnoticetd">
								<i class="fas fa-check" style="color: red;"></i>&nbsp;
								<a href="${articleUrl}&noticeNum=${dto.noticeNum}">${dto.noticeTitle}</a>
							</td>
						</tr>
					</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<div style="float: left; width: 60%; height: 100%;">
			<div style="height: 44%; box-shadow: 0px 0px 10px #ddd; margin-bottom: 20px; background: white; padding-top: 15px;">
				<table class="mainreservationicon">
					<tr>
						<td class="mainreservationicon1">
						<c:if test="${not empty sessionScope.crew}">
							<a href="<%=cp%>/reservation/detail" style="font-size: 15px;"><img src="<%=cp%>/resource/images/card.png" alt="" width="75px;">
								<br>예매 조회
							</a>
						</c:if>
						<c:if test="${empty sessionScope.crew}">
							<a href="<%=cp%>/reservation/uncrew2" style="font-size: 15px;"><img src="<%=cp%>/resource/images/card.png" alt="" width="75px;">
								<br>예매 조회
							</a>
						</c:if>
						</td>
						<td class="mainreservationicon1">
							<a href="<%=cp%>/qna/main" style="font-size: 15px;"><img src="<%=cp%>/resource/images/qna.png" alt="" width="80px;">
								<br>QnA
							</a>
						</td>
						<td class="mainreservationicon1">
							<a href="<%=cp%>/freeBoard/list" style="font-size: 15px;"><img src="<%=cp%>/resource/images/freeboard.png" alt="" width="80px;">
								<br> 자유게시판
							</a>
						</td>
						<td class="mainreservationicon1">
							<a href="<%=cp%>/lostBoard/list" style="font-size: 15px;"><img src="<%=cp%>/resource/images/lost.png" alt="" width="70px;">
								<br>유실물 센터
							</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="maintop1" style="text-align:center; box-shadow: 0px 0px 10px #ddd; height: 50%; background: white; padding-top: 5px;">
				<table class="z" style="width: 100%; height: 97%;">
					<tr>
						<td style="width: 50%; border-right: 1px dashed #ddd;">
							<a href="<%=cp%>/notice/article?page=1&noticeNum=11">
								<img src="<%=cp%>/resource/images/promotion.jpg" width="280px" height="150px" style="margin-bottom: 5px;">
							</a>
						</td>
						<td style="width: 50%;">
							<a href="<%=cp%>/suggest/list">
								<img src="<%=cp%>/resource/images/sound.jpg" width="280px;" height="150px;" style="margin-bottom: 5px;" >
							</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- /Extra -->

	<div style=" background: #eff6fc;">
		<div class="maindesign" style="padding-bottom: 50px; clear: both;">   <!-- mainhot --> 
			<div class="mainhot">
				<h2 style="float: left; font-weight: bold;">추천 여행상품</h2>
				<p style="clear:both; float: right; padding-right: 50px;">
					<a href="<%=cp%>/travel/main">더 많은 상품 보기<i class="fas fa-plus"></i></a>
				</p>
			</div>
			<c:forEach var="dto"  items="${travelList}">
			<div class="3u"  style="display: inline-block; width: 270px; box-shadow: 0px 0px 10px #ddd; background:white; margin-left: 13px; margin-right: 13px;">
					<p>
						<a href="<%=cp%>/travel/travel?pmCode=${dto.pmCode}">
							<img src="<%=cp%>/uploads/travel/${dto.saveFileName}" style="width: 270px; height: 200px;">
						</a>
					</p>
					<div style="margin: 10px;">
						<p style="height: 50px; font-weight: bold; ">${dto.pmTitle}</p>
						<p style="color: orange; font-weight: bold;"><fmt:formatNumber value="${dto.pmPrice}" pattern="#,###" /></p>
					</div>
			</div>
			</c:forEach>
		</div>
	</div>
</div>
<!-- /Main -->

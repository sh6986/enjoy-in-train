<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style>

.homepage #page {
    padding: 2em 0em;
    padding-bottom: 500px;
}

.table1{
	width:100%; 
	text-align: left;
	border: 1px solid #BDBDBD;
}

.tr1{
	height:45px;
	border-bottom:  1px solid #BDBDBD;
}

.col{
	font-weight:10px;
	width:180px; 
	text-align: center;
	border: 1px solid #BDBDBD;
}

.col2{
	padding-left: 20px;
}

.ticket1{
	margin-top: 50px;
	width: 1200px;
	height: 380px;
	padding:0 110px 0 110px;
	border: 1px solid #BDBDBD;
	overflow-y:scroll;
}
.ticket2{
	margin: 15px 100px 10px 60px;
	width: 846px;
	height: 345px;
	border: 3px solid #273267;
}

.ticket3{
	width: 347px;
	margin: 3px;
	float: left;
	padding: 10px;
	height: 333px;
	border: 1px solid black;
}

.ticket4{
	width: 482px;
	margin: 3px 5px 0px 0px;
	float: left;
	height: 333px;
	border: 1px solid black;
}

.ticket4 tr td{
	width: 465px;
	height: 40px;
	padding-left: 10px;
	border-color: black;
}

.back{
	background: #ddd;
}

</style>

<script type="text/javascript">
function info_print() {
	var initBody = document.body.innerHTML;
	
	window.onbeforeprint = function () {
	document.body.innerHTML = document.getElementById("test").innerHTML;
	}
	
	window.onafterprint = function () {
	document.body.innerHTML = initBody;
	}
	
	window.print();
}

</script>
	<!-- Main -->
		<div id="page" >
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="9u skel-cell-important">
						<section>
							<header>
								<div style="width:1200px; text-align:center; height:150px; line-height:150px; border: 1px solid #BDBDBD">
									<p style="font-weight:bold; font-size: 20px;"><i class="fas fa-check-circle" style=" color: #273267;"></i>&nbsp;????????? ????????? ?????????????????????.</p>
								</div>
							</header>
						</section>
					
						<div style="width: 1200px; text-align: center;">

						 	<table class="table1">
						 		<tr class="tr1" style="border-top: 2px solid #BDBDBD;">
						 			<td class="col" style="background: #273267"><b style="color: white;">????????????</b></td>
						 			<td class="col2"><fmt:formatNumber value="${map.trPrice}" pattern="#,###"/>??? [ <fmt:formatNumber value="${map.point}" pattern="#,###"/> ????????? ?????? ]</td>
						 		</tr>
						 	</table>
						 	
						 	<table class="table1">
						 		<tr class="tr1" style="border-top: 2px solid #BDBDBD;">
						 			<td class="col" style="background: #273267; color: white;"><b style="color: white;">????????????</b></td>
						 			<td class="col2">${map.trDate}</td>
						 		</tr>
						 		<tr class="tr1">
						 			<td class="col" style="background: #273267; color: white;"><b style="color: white;">????????????</b></td>
						 			<td class="col2">${map.trainName}</td>
						 		</tr>
						 		<tr class="tr1">
						 			<td class="col" style="background: #273267;  color: white;"><b style="color: white;">????????????</b></td>
						 			<td class="col2">${map.trainCode}</td>
						 		</tr>
						 		<tr class="tr1">
						 			<td class="col" style="background: #273267; color: white;"><b style="color: white;">??????</b></td>
						 			<td class="col2">${map.total} ???</td>
						 		</tr>
						 	</table>
						 	<table class="table1">
						 		<tr class="tr1"><td class="col2">* ????????? ??????????????? ???????????? ???????????? ??????????????????.<td></tr>
						 	</table>
						</div>
						
						<div style="width: 1200px; text-align: center;">
							<button onclick="javascript:location.href='<%=cp%>/main';" style="margin:20px; width:160px; font-weight:bold; font-size:15px; border-radius:5px; height:40px; background: #273267; color: white; border: none;">???????????? ??????</button>
							<button onclick="javascript:location.href='<%=cp%>/reservation/${empty sessionScope.crew?'uncrew2':'detail'}';" style="margin:20px; width:160px; font-weight:bold; font-size:15px; border-radius:5px; height:40px; background: #273267; color: white; border: none;">????????????</button>
							<button onclick="info_print()" style="margin:20px; width:160px; font-weight:bold; font-size:15px; border-radius:5px; height:40px; background: #273267; color: white; border: none;">????????? ??????</button>
						</div>
						
						<div class="ticket1">
						  <c:forEach items="${list}" var="ticket">
							<div class="ticket2">
								<div class="ticket3">
									<table>
										<tr>
											<td>
												&nbsp;&nbsp;????????????<br>
												&nbsp;&nbsp;1.&nbsp; ?????????(Home-Ticket)??? ???????????? ????????? <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												???????????? ??????????????? ??????, ???????????? ???????????? <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;?????? ????????????????????????.<br>
												&nbsp;&nbsp;2.&nbsp;????????? ??????????????? ????????? ?????? ???????????? <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;??????????????? ?????????.
												<br><br>
											</td>
										</tr>
										<tr>
											<td align="center">
												<img src="<%=cp%>/resource/images/qrCodeReservation.jpg" width="100" height="100">
												<br>
											</td>
										</tr>	
										<tr>
											<td style="background: #dddddd; height: 30px; margin-top: 10px;">
												&nbsp;&nbsp;?????? ?????? : 1234-5678
											</td>
										</tr>
									</table>
								</div>
								<div class="ticket4">
									<table style="margin-bottom: 0px;">
										<tr>
											<td style="width:100px; ">?????????</td>
											<td colspan="2" style="font-size: 20px; font-weight: bold; line-height: 1px;">${map.trDate}<br><br></td>
										</tr>
										<tr>
											<td colspan="3" style="font-size: 30px;">${map.startCode}&nbsp;???&nbsp;${map.endCode}<br><br><br></td> 
										</tr>
										<tr>
											<td colspan="3" style="font-size: 30px;">${map.stTime}&nbsp;???&nbsp;${map.endTime}<br><br></td>
										</tr>
										<tr>
											<td style="width: 100px;">${map.trainName}</td>
											<td style="width:270px;">${map.trainCode}??????(${map.roomGrade})</td> 
											<td style="border: 1px soild #cccccc; width: 100px; font-weight: bold;">${map.roomNum}?????? ${ticket.seatNum}???</td>
										</tr>
										<tr>
											<td colspan="3">????????????&nbsp;&nbsp;${ticket.seatType}</td>
										</tr>
										<tr class="back">
											<td  style="width:350px;">???????????? &nbsp;<fmt:formatNumber value="${ticket.seatPay}" pattern="#,###"/>???</td>
											<td style="width:290px;">???????????? &nbsp; <fmt:formatNumber value="${ticket.disCount}" pattern="#,###"/>???</td>
											<td>????????????&nbsp;<fmt:formatNumber value="${ticket.seatPay}" pattern="#,###"/>???</td>
										</tr>
										<tr>
											<td colspan="3" style="font-weight: bold; padding-top: 5px;">??? ?????? ??? ????????? ??????????????? ????????? ??? ??????????????? ????????????.</td>
										</tr>
									</table>
								</div>
							</div>
						  </c:forEach>
						</div>
					</div>
				</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
</div>
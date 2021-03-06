<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">

<style type="text/css">
.homepage #main{
	margin-top: 0em;
    padding-top: 0em;
}
 
.alert-info {
    border: 1px solid #9acfea;
    border-radius: 4px;
    background-color: #d9edf7;
    color: #31708f;
    padding: 15px;
    margin-top: 10px;
    margin-bottom: 20px;
}
 
.boxTF{
	width: 300px;
}


.btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	align: left;
	
}

.help-block{
	font-size: 12px;
}


.mypage {
	position: relative;
    width: 50%;
    border: 1px solid #cccccc;
    height: 180px;
    margin-left: 100px;
    border-radius: 10px;
    padding-left: 70px;
}
.mypage:after, .arrow_box:before {
	right: 100%;
	top: 50%;
	border: solid transparent;
	content: " ";
	height: 0;
	width: 0;
	position: absolute;
	pointer-events: none;
}

.mypage:after {
	border-color: rgba(163, 219, 255, 0);
	border-right-color: #EAEAEA;
	border-width: 30px;
	margin-top: -30px;
}
.mypage:before {
	border-color: rgba(194, 225, 245, 0);
	border-right-color: #EAEAEA;
	border-width: 40px;
	margin-top: -40px;
}

.listtt td{
    padding-top: 5px;
}

.mypagemy{
    width: 14%;
    border: 1px solid white;
    border-radius: 5px;
    float: left;
    text-align: center;
    margin-bottom: 10px;
    margin-top: 18px;
    background: #fefefe;;
    height: 30px;
    font-weight:bold;
}
.mypagemy2{
	border: none;
	width: 35%;
	float: left;
	margin-bottom: 10px;
	margin-top: 20px;
	padding-left: 15px;
}

.mypagemain{width: 100%; float: left;}
.mypagemain2{width: 100%; float: left;}
.mypagemain3{width: 100%; float: left;}

.crewreservation3 :hover {
	background: #f5fffa;
}

.crewreservation4 :hover {
	
}

a{
	color: black;
}
</style>


<script type="text/javascript">

$(function(){
	
	$("ul.tabs li").click(function() {
		var tab = $(this).attr("data-tab");

			$("ul.tabs li").each(function(){
				$(this).removeClass("active");
			});
			$("#tab-"+tab).addClass("active");
		
		if(tab==""){
			tab="1";
		}
		
		if(tab=="0") {
			$("#crewreservation").hide();
			$("#crewreservation2").hide();
			
		} else if(tab=="1") {
			$("#crewreservation").show();
			$("#crewreservation2").hide();
		} else if(tab=="2") {
			$("#crewreservation").hide();
			$("#crewreservation2").show();
		}
	});
});

</script>


<!-- Main -->
	<div id="page">
			<!-- Main -->
			<div id="main" class="container">
			 <div class="row">	
			
				<!-- ?????? ?????? -->
				
					<header style="width: 100%;">
						<h2><i class="fas fa-id-card-alt"></i> MyPage<br><br></h2>
					</header>
					
					<img src="<%=cp%>/resource/images/user1.PNG" alt="" width="125px;" height="150px" style="float: left;  margin: 20px 0px 10px 40px;">
					
				<div class="mypage">
					<div class="mypagemain">
					<div class="mypagemy">??????</div> <div class="mypagemy2">${dto.crewName}</div>
					<div class="mypagemy">MY????????? </div> <div class="mypagemy2"><fmt:formatNumber value="${dto.point}" pattern="#,###"/>???</div>
					
					</div>
					<div class="mypagemain2">
					<div class="mypagemy">????????????</div> <div class="mypagemy2">${dto.crewBirth}</div>
					<div class="mypagemy">????????????  </div> <div class="mypagemy2">${dto.crewTel}</div>
					</div>
					<div class="mypagemain3">
					<div class="mypagemy">?????????</div> <div class="mypagemy2">${dto.crewEmail}</div>
					<div class="mypagemy">?????? ??????   </div> <div class="mypagemy2">${dto.crewChatWarning} ???</div>
					</div>
					
			     </div>
			     
			     
			     
		     	<div style="width: 100%; padding-top: 50px; clear: both;">
					<ul class="tabs">
						<li id="tab-1" data-tab="1">?????????????????????</li>
						<li id="tab-2" data-tab="2">????????????????????????</li>
						<li id="tab-0" data-tab="0"><a href="<%=cp%>/crew/update">???????????? ??????</a></li>
					</ul>
				</div>
				
				<div id="crewreservation" style="display: none; width: 100%;">
					<table style="width:100%; margin-top: 50px; float: left;" >
				 		<tr style="height:40px; font-weight:bold; border-top: 2px solid #EAEAEA; background: #EAEAEA; text-align: center;">
				 			<td style="background: #0f0f69e8; color: white;" colspan="7">????????? ????????????</td>
				 		</tr>
				 		<tr style="height:40px; font-weight:bold; background: #EAEAEA; text-align: center;">
				 			<td>?????????</td>
				 			<td>????????????</td>
				 			<td>?????????</td>
				 			<td>?????????</td>
				 			<td>??????</td>
				 			<td>??????</td>
				 			<td>??????</td>
				 		</tr>
						<tbody class="crewreservation3">
				 		<c:forEach items="${list}" var="dto">
					 		<tr class="listtt" style="text-align: center;" >
					 			<td>${dto.trDate}</td>
					 			<td>${dto.trCategory}&nbsp;${dto.trainCode}</td>
					 			<td>${dto.startCode}</td>
					 			<td>${dto.endCode}</td>
					 			<td><fmt:formatNumber value="${dto.trPrice}" pattern="#,###"/></td>
					 			<td>${dto.count}</td>
					 			<td>????????????</td>
					 		</tr>
				 		</c:forEach>
				 		</tbody>
					</table>
				</div>
				<div id="crewreservation2" style="display: none; width: 100%;">
					<table  style="width:100%; margin-top: 50px;">
						<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA; text-align: center;">
						 	<td style="background: #382a31; color: white;" colspan="5">???????????? ????????????</td>
						</tr>
						<tr style="height:40px; font-weight:bold; background: #EAEAEA; text-align: center;">
							<td>????????????</td>
							<td>???????????? ?????? </td>
							<td>????????? </td>
							<td>????????????</td>
							<td>????????????</td>
						</tr>
						<tbody class="crewreservation3">
						<c:forEach var="dto" items="${list2}" varStatus="status">
							<tr style="text-align: center; height: 40px; color: black;">
								<td> ${dto.reservationNumber} </td>
								
								<c:if test="${dto.prpayment==1}">
									<td> <a href="<%=cp%>/crew/paymentSuccess?prSeq=${dto.prSeq}">${dto.pmTitle}</a></td>
								</c:if>
								
								<c:if test="${dto.prpayment!=1}">
									<td> <a href="<%=cp%>/crew/receipt?prSeq=${dto.prSeq}">${dto.pmTitle}</a></td>
								</c:if>
								
								<td> ${dto.crewName} </td>
								<td> ${dto.prReservationDate.substring(0, 10)} </td>
								<td> 
									<c:if test="${dto.prpayment==1}">
										????????????
									</c:if> 
								</td>
							</tr>
						</c:forEach> 
						</tbody>
					</table>
				</div>
			</div>
			<!-- /???????????? -->
			</div>
		</div>
		<!-- Main -->

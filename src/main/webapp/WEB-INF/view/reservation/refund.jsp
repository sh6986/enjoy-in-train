<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>


<style>
table{
	border: 1px solid #BDBDBD;
}
table td{
	border-right: 1px solid #BDBDBD;
}
table tr{
	//border-bottom: 1px solid #BDBDBD;
}
</style>

<script type="text/javascript">
$(function(){
	$("#reqrefundBtn").click(function(){
		var f=document.refundForm;
		f.submit();
	});
});

$(function(){
    $("#allCheck").click(function(){
        if($("#allCheck").is(":checked")){
        	$(".seatCheck").attr("checked","checked");
        }else{
        	
        }
    });
});


</script>
	<!-- Main -->
		<div id="page" >
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>발권내역/취소</h2>
								<span class="byline">TICKET DETAILS/DETAIL</span>
								<div style="width: 1200px; text-align: center;">
								<form action="<%=cp%>/reservation/requestrefund" name="refundForm" method="post">
								<input type="hidden" value="${trCode}"  name="trCode">
								 	<table style="width:100%;  ">
								 		<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA;">
								 			<td style="background: #273267;"><input id="allCheck" type="checkbox"></td>
								 			<td style="background: #273267; color: white;">승차일</td>
								 			<td style="background: #273267; color: white;">열차종류</td>
								 			<td style="background: #273267; color: white;">열차번호</td>
								 			<td style="background: #273267; color: white;">출발역</td>
								 			<td style="background: #273267; color: white;">도착역</td>
								 			<td style="background: #273267; color: white;">출발시간</td>
								 			<td style="background: #273267; color: white;">도착시간</td>
								 			<td style="background: #273267; color: white;">승객유형</td>
								 			<td style="background: #273267; color: white;">좌석정보</td>
								 		</tr>
								 		<c:forEach items="${list}" var="dto">
									 		<tr style="height:40px; border-bottom: 1px solid #BDBDBD">
									 			<td><input class="seatCheck" type="checkbox" name="rsseatCode" value="${dto.rsseatCode}"></td>
									 			<td>${dto.trDate}</td>
									 			<td>${dto.trCategory}</td>
									 			<td>${dto.trainCode}</td>
									 			<td>${dto.startCode}</td>
									 			<td>${dto.endCode}</td>
									 			<td>${dto.stTime}</td>
									 			<td>${dto.endTime}</td>
									 			<td>${dto.seatType}</td>
									 			<td>${dto.roomNum}호실 ${dto.seatNum}</td>
									 		</tr>
								 		</c:forEach>
								 	</table>
								 	<div style="text-align:left; border: 1px solid #BDBDBD; padding: 20px;">
								 		<span>· 인터넷에서 실제 환불이 가능한 승차권 내역만 조회됩니다.</span><br>
										<span>· 티켓에 표시된 출발시각 전까지 인터넷 환불이 가능하며, 이후에는 역창구를 이용해서 환불을 요청하실 수 있습니다.</span><br>
										<span>· 환불하시면 위약금이 발생할 수 있으며 위약금을 공제한 잔액을 환불하여 드립니다.</span><br>
								 	</div>
								 	<br>
								 	<button type="button" id="reqrefundBtn" style="font-weight:bold; font-size:15px; border-radius:5px; width:100px; height:30px; background: #273267; color: white; border: none;">환불요청</button>
								 	<br>
								</form>
								</div>
							</header>
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
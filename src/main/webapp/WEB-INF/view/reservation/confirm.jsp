<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


<style>
table td{
	border-left: 1px solid #BDBDBD;
}

table{
	border: 1px solid #BDBDBD;
}

</style>

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

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			if($.trim(data)=="error") {
				listPage(1);
				$(selector).html(data);
				return false;
			}	
			$(selector).html(data);
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

</script>

<script type="text/javascript">

function requestPay(){
    var IMP = window.IMP; // 생략가능
    IMP.init('imp72612764'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
    var msg;
    var totalPay= $("#totalPay").val();
    
    //결제 정보
    IMP.request_pay({
        pg : 'kakaopay',
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(),
        name : '기차예매',
        amount : totalPay,
        buyer_email : '${dto.crewEmail}',
        buyer_name : '${dto.crewName}',
        buyer_tel : '${dto.crewTel}',
        buyer_addr : '경기도 광명시',
        buyer_postcode : '123-456'
    }, function(rsp) {
        if ( rsp.success ) {
            //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
            jQuery.ajax({
                url: "/reservation/reservation", //cross-domain error가 발생하지 않도록 주의해주세요
                type: 'POST',
                dataType: 'json',
                data: {
                    imp_uid : rsp.imp_uid
                    //기타 필요한 데이터가 있으면 추가 전달
                }
            }).done(function(data) {
                //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                if ( everythings_fine ) {
                    msg = '결제가 완료되었습니다.';
                    msg += '\n고유ID : ' + rsp.imp_uid;
                    msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                    msg += '\결제 금액 : ' + rsp.paid_amount;
                    msg += '카드 승인번호 : ' + rsp.apply_num;
                    
                    alert(msg);
                } else {
                 
                }
            });
            //성공시 이동할 페이지
            var f=document.reservationForm;
            f.submit();
        } else {
            msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
            //실패시 이동할 페이지
            history.back();//전상태로 다시 돌아옴
            alert(msg);
        }
    });
};  

function reCal(){
	var point=$("#point").val();
	var totalPay=$("#totalPay").val();
	var totalPoint=$("#totalPoint").val();
	if(point>${totalPoint}){
		alert("현재 보유한 포인트 내에서만 사용 가능합니다.");
		return;
	}
	$("#totalPay").val(${map.totalPay}-point);
	$("#totalPoint").val(${totalPoint}-point);
	
	
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
								<form action="<%=cp%>/reservation/reservation"  name="reservationForm" method="post">
								<h2>예약확인</h2>
								<span class="byline">confirm</span>
								<div style="width: 1200px; text-align: center;">
								<input type="hidden" value="${map.day}" name="trDate">
								<input type="hidden" value="${map.startSt}" name="startCode">
								<input type="hidden" value="${map.endSt}" name="endCode">
								<input type="hidden" value="${map.trainCode}" name="trainCode">
								<input type="hidden" value="${map.roomNum}" name="roomNum">
								<input type="hidden" value="${map.total}" name="total">
								
								<input type="hidden" value="${map.trainName}" name="trainName">
								<input type="hidden" value="${map.totalPay}" name="totalPay">
								<input type="hidden" value="${map.crewName}" name="crewName">
								<input type="hidden" value="${map.roomGrade}" name="roomGrade">
								<input type="hidden" value="${map.stTime}" name="stTime">
								<input type="hidden" value="${map.endTime}" name="endTime">
								
								<input type="hidden" value="${map.name}" name="name">
								<input type="hidden" value="${map.password}" name="password">
								<input type="hidden" value="${map.tel}" name="tel">
								<input type="hidden" value="${map.email}" name="email">
								
								 	<table style="width:100%;  ">
								 		<tr style="height:40px; background:#EAEAEA; border-top: 2px solid black;">
								 			<td style="background: #273267;"><b style="color: white;">승차일자</b></td>
								 			<td style="background: #273267;"><b style="color: white;">열차종류</b></td>
								 			<td style="background: #273267;"><b style="color: white;">열차번호</b></td>
								 			<td style="background: #273267;"><b style="color: white;">출발역</b></td>
								 			<td style="background: #273267;"><b style="color: white;">도착역</b></td>
								 			<td style="background: #273267;"><b style="color: white;">출발시각</b></td>
								 			<td style="background: #273267;"><b style="color: white;">도착시각</b></td>
								 			<td style="background: #273267;"><b style="color: white;">인원</b></td>
								 			<td style="background: #273267;"><b style="color: white;">결제금액</b></td>
								 		</tr>
								 		<tr style="height: 40px;">
								 			<td style="width: 160px;">${map.day}</td>
								 			<td style="width: 130px;">${map.trainName}</td>
								 			<td style="width: 130px;">${map.trainCode}</td>
								 			<td style="width: 130px;">${map.startSt}</td>
								 			<td style="width: 130px;">${map.endSt}</td>
								 			<td style="width: 130px;">${map.stTime}</td>
								 			<td style="width: 130px;">${map.endTime}</td>
								 			<td style="width: 100px;">${map.total}</td>
								 			<td style="width: 160px; text-align: center;">
								 				<b><input readonly="readonly" name="trPrice" type="text" id="totalPay" style="font-weight:bold; color:red; text-align:center; border: none;" value="${map.totalPay}"></b>
								 			</td>
								 		</tr>
								 	</table>
								 	<table style="width: 100%;">
								 		<tr style="height:40px; background:#EAEAEA; border-top: 2px solid black;">
								 			<td style="background: #273267;"><b style="color: white;">객실등급</b></td>
								 			<td style="background: #273267;"><b style="color: white;">좌석정보</b></td>
								 			<td style="background: #273267;"><b style="color: white;">승객유형</b></td>
								 			<td style="background: #273267;"><b style="color: white;">운임요금</b></td>
								 			<td style="background: #273267;"><b style="color: white;">할인금액</b></td>
								 			<td style="background: #273267;"><b style="color: white;">영수금액</b></td>
								 		</tr>
								 		<c:set var="i" value="0"/>
								 		<c:forEach items="${seatList}" var="num">
								 			<c:set var="i" value="${i+1}"/>
									 		<tr style="height: 40px; border-bottom: 1px solid #BDBDBD" >
									 			<td>${map.roomGrade}</td>
									 			<td>${map.roomNum}호실 ${num.seatNum}
									 				<input type="hidden" name="seatNum${i}" value="${num.seatNum}">
									 			</td>
									 			<td>${num.seatType}
									 				<input type="hidden" name="seatType${i}" value="${num.seatType}">
									 			</td>
									 			<td><fmt:formatNumber value="${num.seatPay}" pattern="#,###"/>
									 			</td>
									 			<td><fmt:formatNumber value="${num.disCount}" pattern="#,###"/>
									 				<input type="hidden" name="disCount${i}" value="${num.disCount}"></td>
									 			<td><fmt:formatNumber value="${num.seatPay-num.disCount}" pattern="#,###"/>
									 				<input type="hidden" name="seatPay${i}" value="${num.seatPay-num.disCount}"></td>
									 		</tr>
								 		</c:forEach>
								 	</table>
								 	<c:if test="${not empty sessionScope.crew}">
									 	<table style="width: 100%;">
									 		<tr style="height:40px; border-top: 2px solid black;">
									 			<td style="width:200px; background:#273267;"><b style="color: white;">포인트</b></td>
									 			<td style="text-align: left;"><input value="0" name="point" id="point" style="margin-left:10px; " type="text">
									 				&nbsp;현재포인트:
									 				<input readonly="readonly" type="text" id="totalPoint" style="text-align:left; border: none;" value="${totalPoint}">
									 			</td>
									 		</tr>
									 	</table>
								 	</c:if>
								 	<button type="button" onclick="requestPay()" style="font-weight:bold; font-size:15px; border-radius:5px; width:100px; height:30px; background: #273267; color: white; border: none;">결제하기</button>
									<button type="button" onclick="reCal()" style="font-weight:bold; font-size:15px; border-radius:5px; width:100px; height:30px; background: #ddd; color: black; border: none;">다시계산</button>
									<button onclick="aa();" style="display: none;">좌석예약(테스트)</button>
								</div>
								</form>
							</header>
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
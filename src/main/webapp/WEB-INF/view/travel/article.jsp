<%@page import="org.springframework.data.mongodb.core.aggregation.ArrayOperators.In"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<style type="text/css">

a{
	color: #000; text-decoration: none;
}

a:hover, a:active{
	color: #77AF9C; text-decoration: underline;
}

#layout{
	margin: 30px auto; width: 210px;
}

.calendar table{
	text-align : center;
	width: 100%; border-spacing: 0; border-collapse: collapse;
}

.calendar table tr{
	height: 30px; text-align: center;
}

.calendar table .day{
	height: 30px; text-align: center;
	width: 10px; height: 10px;
}

.calendar .day:hover{
	background : #77AF9C;
	color : white;
	border-radius: 150px;
}

.calendar .day:visited{
	background : #77AF9C;
	color : white;
	border-radius: 150px;
}


 .calendar td:nth-child(7n+1){
	color: red;
}

.calendar td:nth-child(7n){
	color: blue;
}

.calendar td .gray{
	 color: gray;
} 

</style>

<style type="text/css">
.homepage #main {
	margin-top: 0em;
	padding-top: 0em;
}

.ui-widget-header {
	background: none;
	border: none;
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
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

.btn {
	width: 100px;
	margin: 20px 10px;
	background: white; 
	font-weight: bold; 
	height: 30px;"
}

table td {
	padding-top: 6px;
}

.title {
	text-align: center;
	 width: 150px;
}

#train, #train2 {
	clear: both;
	margin-left: 10px;
	width: 95%;
}

#train tr, #train2 tr {
	width: 20%;
	text-align: center;
}

#train td, #train2 td {
	border: 1px solid #cccccc;
}

#travelTable tr {
	padding-top: 10px;
	padding-bottom: 10px;
}

.title {
	width: 200px;
	font-weight: bold;
}
</style>

<script type="text/javascript">
$(function(){
	   $(".calendar .day").click(function() {
	      var year = ${year};
	      var month =   ${month};
	      var day = $(this).attr("data-tab");
	      var data = year + '???' + month + '??? ' + day + '???';
	         
	      $("#selectDate").html(data);
	      
	      month = month<10 ? "0"+month : month;
	      day = day <10 ? "0"+day : day;
	      
	      var date2 = year +"-" +month+"-"+day;
	      
	      $(".reservationForm").show();
	      $("input[name=pmStartDate]").val(date2);

	      
	   });
	});

</script>

<button type="button" id="btn" class="btn" onclick="javascript:location.href='<%=cp%>/travel/travel';" style="	background: white;"><i class="fas fa-hand-point-left"></i></button>

<form name="travelArticleForm" method="get" enctype="multipart/form-data">
	<table id="travelTable" style="border-spacing: 0px; border-collapse: collapse; width: 100%;">
		
		<tr align="left" height="40"
			style="border-bottom: 1px solid #382a31; border-top: 3px solid #382a31;">
			<td class="title" style="padding-left: 10px; text-align: center; background: #382a31; color: white; font-size: 18px;" colspan="5" width="100%;">${dto.pmTitle}</td>
		</tr>


		<tr align="left" height="40"
			style=" border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			<td rowspan="7" colspan="2" style="width: 100px; padding: 10px 20px;">
				
				<c:forEach var="vo" items="${photoList}">
					<img src="<%=cp%>/uploads/travel/${vo.saveFileName}" style="width: 300px; height:200px; ">	
				</c:forEach>
				
			</td>
			<td class="title" style="text-align: center; background: #F7E8E4;">????????????</td>
			<td style="padding-left: 10px; width: 200px;">${dto.pmCode}
				<input type="hidden" name="pmCode" value="${dto.pmCode}">
			</td>
			<td class="title" style="text-align: center; padding-top: 5px;" rowspan="7">
				<table style='width: 250px; margin-left: 30px; margin-right: 30px;' class='calendar'>
					<tr style='border-bottom: 2px solid #cccccc;'>
						<td colspan="8" style="text-align: center; color: black; width: 50px;">
							<button type="button" onclick="calendar( ${preYear}, ${preMonth} , '${dto.getPmCode()}');"
								style="border: 1px solid white; background: white;"><i class='fas fa-arrow-circle-left'></i></button>
								${year}???  ${month} ???
							<button type="button" onclick="calendar( ${lastYear}, ${lastMonth} , '${dto.getPmCode()}');"
								style="border: 1px solid white; background: white;"><i class="fas fa-arrow-circle-right"></i></button>
						</td>
					</tr>
					<tr><td>???</td><td>???</td><td>???</td><td>???</td><td>???</td><td>???</td><td>???</td></tr>
					<tbody>
						<tr>
							<td>${result}</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
 
		<tr align="left" height="40"
			style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			<td class="title"   style="text-align: center; background: #F7E8E4;">????????????</td>
			<td style="padding-left: 10px; width: 343px;">${dto.pmPrice}~</td>
		</tr>

		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td class="title"   style="text-align: center; background: #F7E8E4;">?????????</td>
			<td style="padding-left: 10px; width: 343px;">${dto.partnerName}</td>
		</tr>
		
		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td class="title"   style="text-align: center; background: #F7E8E4;">????????????</td>
			<td style="padding-left: 10px; width: 343px;">${dto.partnerTel}</td>
		</tr>

		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td class="title"   style="text-align: center; background: #F7E8E4;">?????? ??????</td>
			<td style="padding-left: 10px; width: 343px;">
				<select name="prPersonnel">
					<option value="1">1???</option>
					<option value="2">2???</option>
					<option value="3">3???</option>
					<option value="4">4???</option>
					<option value="5">5???</option>
					<option value="6">6???</option>
					<option value="7">7???</option>
					<option value="8">8???</option>
					<option value="9">9???</option>
					<option value="10">10???</option>
				</select>
			</td>
		</tr>

		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			<td class="title"   style="text-align: center; background: #F7E8E4;">?????? ?????? ??????</td>
			<td style="padding-left: 10px; width: 343px;">
				1???
			</td>
		</tr>

		 <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
	      <td class="title"   style="text-align: center; background: #F7E8E4;">????????????</td>
	         <td style="padding-left: 10px; width: 343px;">
	            <span id="selectDate"></span>
	            <input type="hidden" name="pmStartDate" id="pmStartDate">
	         </td>
	      </tr>
	</table>	
		
	<table style=" margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
	
		<tr class="reservationForm" align="center" height="40"
			style="border-bottom: 1px solid #382a31; border-top: 3px solid #382a31; display: none;" >
			<td class="title" style="width: 200px; background: #382a31; color: white;">?????? ??????</td>
			<td class="title" style="background: #382a31; color: white;">??????</td>
			<td class="title" style="width: 200px;background: #382a31; color: white;">?????????</td>
			<td class="title" style="background: #382a31; color: white;">????????????</td>
			<td class="title" style="background: #382a31; color: white;">????????????</td>
			<td class="title" style="background: #382a31; color: white;">????????????</td>
			<td class="title" style=" background: #382a31; color: white;">?????? ?????? ??????</td>
		</tr>
		
		<c:forEach var="vo" items="${startList}">
			<tr class="reservationForm" align="center" style="border-bottom: 1px solid #cccccc; border-bottom: 1px solid #cccccc; display: none;">
				<c:if test="${vo == startList.get(0)}">
					<td rowspan="${startLength}" style="width: 200px; font-weight: bold; background: #F7E8E4;">?????? ??????</td>
				</c:if>
				<td class="title"><input type="radio" name="startTrain"  value="${vo.trainCode}"  ${startList[0] == vo? "checked='checked'" : ""}></td>
				<td class="title">${vo.trainName}</td>
				<td class="title">${vo.trainCode}</td>
				<td class="title">${vo.startTime}</td>
				<td class="title">${vo.endTime}</td>
				<td class="title">${vo.pmCount}</td>
			</tr>
		</c:forEach>
		
		<tr class="reservationForm" align="left" 
			style="border-bottom: 1px solid #cccccc; border-bottom: 1px solid #cccccc;  display: none;">
			<td class="title" style="background: #F7E8E4;">${dto.product}</td>
			<td class="title"><input type="radio" checked="checked"></td>
			<td class="title" colspan="5" style="text-align: left; padding-left: 70px;">${dto.productContent}</td>
		</tr>
		
		<c:forEach var="vo" items="${endList}">
			<tr class="reservationForm" align="left" style="border-bottom: 1px solid #cccccc; display: none;">
				<c:if test="${vo == endList.get(0)}">
					<td class="title"  rowspan="${endLength}" style="background: #F7E8E4;">?????? ??????</td>
				</c:if>
				<td class="title"><input type="radio" name="endTrain" value="${vo.trainCode}" ${endList[0] == vo? "checked='checked'" : ""}></td>
				<td class="title">${vo.trainName}</td>
				<td class="title">${vo.trainCode}</td>
				<td class="title">${vo.startTime}</td>
				<td class="title">${vo.endTime}</td>
				<td class="title">${vo.pmCount}</td>
			</tr>
		</c:forEach>
		
		<tr class="reservationForm" align="left" height="40" style=" display: none;">
			<td class="title" colspan="6" ></td>
			<td><button type="button" id="btn" class="btn" onclick="reservation();"style="	background: white;">????????????</button></td>
		</tr>
	</table>
		
	<c:if test="${photoContentList!=null}">
		<table style=" margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse; width: 1200px;">
			<tr align="center" height="40"
				style="border-bottom: 1px solid #F7E8E4; border-top: 3px solid #F7E8E4; ">
				<td colspan="8" style=" background: #382a31; font-size: 15px; font-weight: bold; color: white;">?????? ?????? ??????</td>
			</tr>
			<tr align="center" style="clear:both; width: 100%; border-bottom: 1px solid #cccccc; margin-top: 200px;">
				<td colspan="6" style="width: 100%">
					<c:forEach var="vo" items="${photoContentList}">
						<img src="<%=cp%>/uploads/travel/${vo.saveFileName}"  style="width: 90%">
					</c:forEach>
				</td>
			</tr>	
		</table>
	</c:if>
	

</form>



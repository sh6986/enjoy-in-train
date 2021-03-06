<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%> 

<form id="detailedCrewForm" name="detailedCrewForm" method="post">
<table style="margin: 10px auto 20px; width: 100%; border-spacing: 1px;">
	<tr height="37" style="background: #ffffff;">
	    <td align="right" width="15%" style="padding-right: 7px;"><label style="font-weight: 900;">아이디</label></td>
	    <td align="left" width="35%" style="padding-left: 5px;"><span>${dto.crewId}</span></td>
	    <td align="right" width="15%" style="padding-right: 7px;"><label style="font-weight: 900;">이름</label></td>
	    <td align="left" width="35%" style="padding-left: 5px;"><span>${dto.crewName}</span></td>
	</tr>
	<tr height="37" style="background: #ffffff;">
	    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">전화번호</label></td>
	    <td align="left" style="padding-left: 5px;"><span>${dto.crewTel}</span></td>
	    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">생년월일</label></td>
	    <td align="left" style="padding-left: 5px;"><span>${dto.crewBirth}</span></td>
	</tr>
	<tr height="37" style="background: #ffffff;">
	    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">이메일</label></td>
	    <td align="left" style="padding-left: 5px;"><span>${dto.crewEmail}</span></td>
		    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">채팅경고</label></td>
		   	 <td align="left" style="padding-left: 5px;"><input style="width: 50px;" name="crewChatWarning" value="${dto.crewChatWarning}"></td>
		   	
	</tr>
</table>
<input type="hidden" name="crewId" value="${dto.crewId}">
</form>


<div id="crewStateDetaile" style="display: none;">
<table style="margin: 10px auto 5px; width: 100%; border-spacing: 1px;"> 
  <c:if test="${listState.size()==0}">
  	<tr height="30" align="center" bgcolor="#ffffff">
  		<td colspan="3">등록된 정보가 없습니다.</td>
	</tr>  
  </c:if>
</table>  
</div>

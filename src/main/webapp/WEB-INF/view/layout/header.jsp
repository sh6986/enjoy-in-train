<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<div id="header" style="background: white; height: 50px; border-bottom: 1px solid #aaa;">
	<div style="width: 1200px; margin: 0 auto; height: 100%; line-height: 46px;">
		<div style="display: inline-block;">
			<a href="<%=cp%>/main" style="font-weight: bold; font-size: 25px; color: black;">
				ENJOY IN TRAIN
			</a>
		</div>
		<div style="display: inline-block; text-align: center; height: 100%;">
			<ul class="menu" style="width: 790px; height: 100%;">
				<li style="height:100%; display: inline-block; margin-left: 0px;">
					<a href="#" style="font-weight: bold;">
						기차예약
					</a>
					<div>
						<ul>
							<li><a href="<%=cp%>/reservation/main">예약 하기</a></li>
							<li><a href="<%=cp%>/reservation/${empty sessionScope.crew?'uncrew2':'detail'}">예약 조회</a></li>
						</ul>
					</div>
				</li>
				<li style="display: inline-block;"><a href="#" style="font-weight: bold;">공지사항</a>
					<div>
						<ul>
							<li><a href="<%=cp%>/notice/list">공지사항</a></li>
							<li><a href="<%=cp%>/faq/list">FAQ</a></li>
						</ul>
					</div>
				</li>
				<li style="display: inline-block;"><a href="<%=cp%>/travel/main" style="font-weight: bold;">프로모션</a>
					<div>
						<ul>
							<li><a href="<%=cp%>/travel/travel">예약 하기</a></li>
							<li><a href="<%=cp%>/booking/detail">예약 조회</a></li>
						</ul>
					</div>
				</li>	
				<li style="display: inline-block;"><a href="#" style="font-weight: bold;">고객센터</a>
					<div>
						<ul>
							<li><a href="<%=cp%>/qna/main">Q&#38;A</a></li>
							<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
							<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
							<li><a href="<%=cp%>/suggest/list">고객의 소리</a></li>
							<li><a href="<%=cp%>/chat/main">채 팅</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
		<div style="text-align: right; display: inline-block; width: 200px; float: right;">
			<ul class="loginmenu" style="display: inline-block;">
				<li>
				<c:if test="${empty sessionScope.crew}">
					<a href="<%=cp%>/crew/login" style="font-weight: bold;">&nbsp;Login</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=cp%>/crew/crew" style="font-weight: bold;"><i class="fas fa-user-plus"></i>&nbsp;Join</a>
				</c:if>
				<c:if test="${not empty sessionScope.crew && sessionScope.crew.crewId != 'a'}">
					<a href="<%=cp%>/crew/mypage" style="font-weight: bold;"><i class="fas fa-user-shield"></i>&nbsp;MyPage</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=cp%>/crew/logout" style="font-weight: bold;"><i class="fas fa-sign-out-alt"></i>&nbsp;Logout</a>
				</c:if>
				<c:if test="${sessionScope.crew.crewId=='a'}">
					<a href="<%=cp%>/admin/trainsales/list" style="font-weight: bold;"><i class="fas fa-user-cog"></i>&nbsp;AdminPage</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=cp%>/crew/logout" style="font-weight: bold;"><i class="fas fa-sign-out-alt"></i>&nbsp;Logout</a>
				</c:if>
				</li>
			</ul>
		</div>
	</div>
</div>

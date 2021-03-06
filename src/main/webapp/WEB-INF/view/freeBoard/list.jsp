<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
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

tr.over {
	background: #f5fffa;
	cursor: pointer;
}

.boxTF{
	width: 150px;
}


#btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background: none;
	border: 1px solid #ccc;
	cursor: pointer;
	border-radius: 5px;
	
}


#btnsearch{
	width: 50px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
}


.listname1 td{
	color: black;
}

.listname1:hover{
	background: #f5fffa;
}

a:-webkit-any-link {
    cursor: pointer;
    text-decoration: none;
    color: black;
}

</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}

</script>

<!-- Main -->
<div id="page">
	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			
			<!-- 사이드 바 메뉴 -->
				<div class="3u">
						<section class="sidebar">
							<header>
								<h2>Customer</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/qna/main">QnA</a></li>
								<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
								<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
								<li><a href="<%=cp%>/suggest/list">고객의소리</a></li>
							</ul>
						</section>
					</div>
			<!-- /사이드바 메뉴 -->
			
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
			
				<section>
					<header>
						<h2>자유게시판</h2>
						<span class="byline">Free | PlEASE FEEL FREE TO WRITE.</span>
					</header>
					
					<div>
						<div style="clear: both;">
								<ul>
									
									<li style="width: 80%; float: left; margin-bottom: 30px; margin-top: -20px;">
										<form name="searchForm" action="<%=cp%>/freeBoard/list" method="post">
		            						<select name="condition" class="selectField, noticebtn">
		                  						<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
		                  						<option value="fbTitle" ${condition=="noticeTitle"?"selected='selected'":""}>제목</option>
		                  						<option value="fbContent" ${condition=="noticeContent"?"selected='selected'":""}>내용</option>
		                  						<option value="crewName" ${condition=="crewName"?"selected='selected'":""}>작성자</option>
		                  						<option value="fbCreated" ${condition=="nCreated"?"selected='selected'":""}>등록일</option>
		            						</select>
		          	  							<input type="text" name="keyword" value="${keyword}" class="noticeinput" width="300px">
		            							<button type="button" class="noticebtn" id="btnsearch" onclick="searchList()">검색</button>
												<button type="button" class="noticebtn" id="btn" onclick="javascript:location.href='<%=cp%>/freeBoard/list';">새로고침</button>
		        						</form>
		        					</li>
		        					<li style="width: 20%; float: left;">
		        					${dataCount}개(${page}/${total_page} 페이지)
		        					</li>
								</ul>
							</div>
						
						
						<table style="width: 100%; border-spacing: 0px; margin: 0px auto; border-collapse: collapse;">
							<tr class="noticebar">
								<th width="60">번호</th>
								<th width="200">제목</th>
								<th width="100">작성자</th>
								<th width="80">작성일</th>
								<th width="60">조회수</th>
								<th width="50">파일</th>
							</tr>
							<c:forEach var="dto" items="${list}">
							 	<tr class="listname1" align="center"  height="35" style="border-bottom: 1px solid #cccccc; color: black;"> 
									<td>${dto.listNum}</td>
									<td align="left" style="padding-left: 20px; color: black; text-decoration: none;">
										<a href="${articleUrl}&num=${dto.fbNum}">${dto.fbTitle} [ ${dto.replyCount} ]
										<c:if test="${dto.gap < 2}">
							               <img src='<%=cp%>/resource/images/new.gif'>
							           	</c:if>
							           </a>	
									</td>
									<td>${dto.crewName}</td>
									<td>${dto.fbCreated}</td>
									<td>${dto.fbHitCount}</td>
									<td>
										<c:if test="${dto.fileCount !=0}">
										<!-- 	<a href="<%=cp%>/freeBoard/download?num=${dto.fbNum}">  -->
											<i class="far fa-file"></i>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<tr>
							</tr>
						</table>
				
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						   <tr height="35">
							<td align="center">
								<c:if test="${sessionScope.crew.crewId != null}">
									<button style="border-radius: 10px; float: right;" type="button" class="btn" id="btn" onclick="javascript:location.href='<%=cp%>/freeBoard/created';">글올리기</button>
							     </c:if>  
							       ${dataCount==0?"등록된 게시물이 없습니다.":paging}
							</td>
						   </tr>
						</table>

					</div>
				</section>
			</div>
			<!-- /메인내용 -->
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->
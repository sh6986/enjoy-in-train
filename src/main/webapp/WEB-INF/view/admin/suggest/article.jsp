<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/lostboardarticle.css" type="text/css">
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}
</style>
<script type="text/javascript">
function login() {
	location.href="<%=cp%>/crew/login";
}


function ajaxJSON(url,type,query,fn){
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"json",
		success:function(data){
			fn(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true);
		},
		error:function(jqXHR){
			if(jqXHR.status==403){
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxHTML(url,type,query,selector) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		success:function(data){
			$(selector).html(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true);
		},
		error:function(jqXHR){
			if(jqXHR.status==403){
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function deleteNotice() {
	  var q = "sgCode=${dto.sgCode}&${query}";
	  var url = "<%=cp%>/admin/suggest/delete?" + q;

	  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
	  	location.href=url;
	}

function updateNotice() {
	  //var q = "sgCode=${dto.sgCode}&page=${page}";
	  var q = "sgCode=${dto.sgCode}&${query}";
	  var url = "<%=cp%>/admin/suggest/update?" + q;

	  location.href=url;
	
	}

//댓글
//리스트 페이징처리
$(function() {
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/admin/suggest/listComment";
	var query = "sgCode=${dto.sgCode}&pageNo="+page;
	var selector = "#listComment";
	
	ajaxHTML(url,"get",query,selector);
}

//댓글 추가
$(function() {
	$(".btnSendComment").click(function() {
		var sgCode = "${dto.sgCode}";
		var $tb=$(this).closest("table");
		var content = $tb.find("textarea").val().trim();
		
		if(! content){
			$tb.find("textarea").focus();
			return false;
		}
		
		content = encodeURIComponent(content);
		
		var url = "<%=cp%>/admin/suggest/createdComment";
		var query = "sgCode="+sgCode+"&content="+content+"&answer=0&";
		
		var fn = function(data) {
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

//댓글 삭제
$(function () {
	$("body").on("click", ".deleteComment", function () {
		if(! confirm("게시물을 삭제하시겠습니까?")){
			return false;
		}
		
		var replyNum = $(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url = "<%=cp%>/admin/suggest/deleteComment";
		var query = "replyNum="+replyNum+"&mode=reply";
		
		var fn = function (data) {
			listPage(page);
			
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

//답글버튼(댓글별 답글 등록 폼,답글 리스트)
$(function() {
	$("body").on("click",".btnCommentAnswer",function(){
		
		var $trCommentAnswer = $(this).closest("tr").next();
		// var $trReplyAnswer = $(this).parent().parent().next();
		// var $answerList = $trReplyAnswer.children().children().eq(0);
		
		var isVisible=$trCommentAnswer.is(':visible');
		var num = $(this).attr("data-replyNum");
		
		if(isVisible){
			$trCommentAnswer.hide();
		} else{
			$trCommentAnswer.show();
			
			//답글리스트
			listReplyAnswer(num);
			
			//답글 개수
			countReplyAnswer(num);
		}
	});
});

//댓글별 답글 리스트
function listReplyAnswer(answer) {
	var url="<%=cp%>/admin/suggest/listReplyAnswer";
	var query = {answer : answer};
	var selector = "#listReplyAnswer"+answer;
	
	ajaxHTML(url,"get",query,selector);
}

//댓글별 답글 개수
function countReplyAnswer(answer){
	var url = "<%=cp%>/admin/suggest/countReplyAnswer";
	var query = {answer:answer};
	
	var fn = function(data) {
		var count = data.count;
		var vid = "#answerCount"+answer;
		$(vid).html(count);
	};
	ajaxJSON(url,"post",query,fn);
}

//댓글별 답글 등록
$(function () {
	$("body").on("click", ".btnSendCommentAnswer", function () {
		var sgCode = "${dto.sgCode}";
		var replyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		var content = $td.find("textarea").val().trim();
		if(!content){
			$td.find("textarea").focus();
			return false;
		}
		
		cotent = encodeURIComponent(content);
		
		var url = "<%=cp%>/admin/suggest/createdComment";
	
		var query = "sgCode="+sgCode+"&content="+content+"&answer="+replyNum;
		
		var fn = function (data) {
			$td.find("textarea").val("");
			
			var state = data.state;
			if(state=="true"){
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

//댓글별 답글 삭제
$(function () {
	$("body").on("click", ".deleteReplyAnswer", function () {
		if(!confirm("게시물을 삭제하시겠습니까 ? ")){
			return;
		}
		var replyNum = $(this).attr("data-replyNum");
		var answer = $(this).attr("data-answer");
		
		var url = "<%=cp%>/admin/suggest/deleteComment";
		var query = "replyNum="+replyNum+"&mode=answer";
		
		var fn = function (data) {
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});


function insertAn(){
	  var q = "sgCode=${dto.sgCode}&${query}";
	  var url = "<%=cp%>/admin/suggest/answer?" + q;

	  location.href=url;
}

</script>

<script type="text/javascript">

</script>



	<!-- Main -->
		<div id="adminpage">
				<div class="trainandtime">
					<a href="<%=cp%>/admin/notice/list">공지사항</a> <span>|</span> <a href="<%=cp%>/admin/qna/main">QnA</a>
					<span>|</span> <a href="<%=cp%>/admin/faq/list">FAQ</a> <span>|</span> <a href="<%=cp%>/admin/lostBoard/list">유실물</a>
					<span>|</span> <a href="<%=cp%>/admin/freeBoard/list">자유게시판</a> <span>|</span> <a href="<%=cp%>/admin/suggest/list">고객의소리</a>
				</div>
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>고객의 소리</h2>
								<span class="byline">THANK YOU FOR YOUR VALUABLE OPINION.</span>
							</header>
							<div id="namul">
					<form name="noticeForm" method="post" >
						<table class="noticearticle">
							<tr class="noticearticletitle">
								<td colspan="4" style="text-align: center; background: #21373F; color: white; font-weight: bold;"> ${dto.sgTitle} </td>
							</tr>
							<tr class="noticearticletitle">
								<td style="text-align: right;" colspan="4">${dto.sgCreated} | 조회 : ${dto.sgHitCount}</td>
							</tr>
							
							<tr style="padding: 5px 5px;">
								<td class="notice-content" colspan="4"><div class="content_scroll"><div class="content_scroll">${dto.sgContent}</div></div></td>
							</tr>
							<c:if test="${dto.anContent!=''}">
								<tr>
									<td class="notice-content" colspan="4">
										<div class="content_scroll"><p>[답변내용입니다]    ${dto.anCreated }</p>
										${dto.anContent}
										</div>
									</td>
								</tr>
							</c:if>
							
							
							<c:forEach var="vo" items="${listFile}">
								<tr height="35" >
				  				  <td colspan="2" align="left" style="padding-left: 5px;">
				    				  <a href="<%=cp%>/admin/suggest/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>
			      					    (<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)
								  </td>
								</tr>
							</c:forEach>
							
							
							<tr>
								<td colspan="2" style="text-align: left;" class="articleReadDto">
								
								<c:if test="${not empty preReadDto}">
			           		   		<a href="<%=cp%>/admin/suggest/article?${query}&sgCode=${preReadDto.sgCode}"> ＜＜이전 글 보기  ＿ ${preReadDto.sgTitle}</a>
			       			 	</c:if>
			       			 	</td>
			       			 	
			       			 	<td colspan="2" style="text-align: right;" class="articleReadDto">
			        			<c:if test="${not empty nextReadDto}">
			             			 <a href="<%=cp%>/admin/suggest/article?${query}&sgCode=${nextReadDto.sgCode}">${nextReadDto.sgTitle} ＿  다음 글 보기 ＞＞ </a>
			        			</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="4">
								<button type="button" class="articlebtn" onclick="javascript:location.href='<%=cp%>/admin/suggest/list?${query}';">리스트</button>
			          				
			          				<button type="button" class="articlebtn" onclick="deleteNotice();">삭제</button>
			          				<c:if test="${dto.anContent==''}">
				          				<button type="button" class="articlebtn" onclick="insertAn();">답변달기</button>
			          				</c:if>
			          			</td>
							</tr>
						</table>
						
						
						
			        </form>
						
			         	
			        </div>
						</section>
					</div>
					
				</div>
			
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
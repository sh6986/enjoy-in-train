<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
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
ul.tabs {
	margin: 5px 0px;
	padding: 0;
	float: left;
	list-style: none;
	height: 35px;
	border-bottom: 1px solid #dddddd;
	width: 100%;
}
ul.tabs li {
	float: left;
	margin: 0;
	cursor: pointer;
	padding: 0px 21px ;
	height: 35px;
	line-height: 35px;
	overflow: hidden;
	position: relative;
}
ul.tabs li:hover {
	background: #e7e7e7;
}	
ul.tabs li.active{
	font-weight: 700;
	border: 1px solid #dddddd;
	border-bottom-color:  transparent;
	background: #ffffff;
}

#btn{
	width: 100px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
}

#updatebtn{
	width: 50px; 
	height: 30px;  
	background-color: white; 
	border-color: #cccccc;
	float: right;
	border-radius: 10px;
	margin-right: 5px;
}

#deletebtn{
	width: 50px; 
	height: 30px;  
	background-color: white; 
	border-color: #cccccc;
	float: right;
	border-radius: 10px;
	margin-right: 5px;
}

.content_scroll{
	overflow: auto;
	max-width: 1100px;
	max-height: 900px;
}

</style>

<script type="text/javascript">
$(function(){
	$("#tab-0").addClass("active");
	list(0);
});

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


$(function(){
	$("#tab-${group}").addClass("active");
	
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$(".tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		list(tab);
		
	});
});

$(function(){
	$(".board-list tr").hover(function(){
		$(this).addClass("over");
	}, function(){ // ???????????? ????????????
		$(this).removeClass("over");
	});

});

function list(group){
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/qna/list";
	var query="group="+ group;
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// ?????? ???
function insertForm(){
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url = "<%=cp%>/qna/created";
	var query = "";
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// ????????? ???
function articleQnA(num, secret, id) {
	
	if(secret=="1") {
		if(id!="${sessionScope.crew.crewId}" && "${sessionScope.crew.crewId}" != "a") {
			alert("???????????? ????????? ??? ????????????.");
			return;
		}
	}
	
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/qna/article";
	var query="num="+num;
	
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

function updateForm(num){
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/qna/update";
	var query = "num="+num;
	
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

function deleteQnA(num) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/qna/delete";
	
	var query="num="+num;
	
	if(! confirm("??? ???????????? ?????? ?????? ???????????? ? "))
		  return;
	
	var fn = function(data){

		list(0);
	};
	
	ajaxJSON(url, "post", query, fn);		
}

function sendOk(mode) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var f = document.QnAForm;

	if(! f.categoryNum.value) {
		alert("?????? ?????? ???????????????. ");
		f.categoryNum.focus();
		return;
	}
        
	if(! f.qnaTitle.value) {
		alert("????????? ???????????????. ");
		f.subject.focus();
		return;
	}
	
	var group = f.categoryNum.value;
	
	var url = "<%=cp%>/qna/"+mode;
	var query = $('form[name=QnAForm]').serialize(); +"&group="+group;
	
	var fn = function(data){
		var state=data.state;
        if(state=="false")
            alert("???????????? ??????(??????)?????? ???????????????. !!!");
		
        list(group);		
	}

	ajaxJSON(url, "post", query, fn);	
	
}


</script>
	<!-- Main -->
		<div id="page">
				
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">

					<div class="3u">
						<section class="sidebar">
							<header>
								<h2>Customer</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/qna/main">QnA</a></li>
								<li><a href="<%=cp%>/lostBoard/list">?????????</a></li>
								<li><a href="<%=cp%>/freeBoard/list">???????????????</a></li>
								<li><a href="<%=cp%>/suggest/list">???????????????</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header style="margin: 0px; padding: 0px">
								<h2>Q&#38;A</h2>
								<span class="byline" style="width: 500px;">Question And Answer</span>
							</header>
							
							<div style="clear: both;">
								<ul class="tabs">
									<li id="tab-0" data-tab="0">??????</li>
									<c:forEach var="vo" items="${groupList}">
										<li  id="tab-${vo.categoryNum}" data-tab="${vo.categoryNum}">${vo.category}</li>
									</c:forEach> 
								
								</ul>
							</div>
							
							
							<div id ="tab-content" style="clear: both; padding: 10px 0px 0px; width: 880px;"></div>
							
							</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
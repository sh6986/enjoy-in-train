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

.help-block {
	margin-top: 3px; 
	width: 200px;
	text-align: center;
}	

element.style {
    text-align: center;
    vertical-align: middle;
    width: auto;
    min-height: 0px;
    max-height: none;
    height: 150px;
}

.ui-widget-header {
	background: none;
	border: none;
	line-height:35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}

.ui-dialog .ui-dialog-content {
    position: relative;
    border: 0;
    padding: 20px;
    background: none;
    overflow: hidden; 
    height: 150px;
  
}

.menu-height1{
	width: 60%; 
	float:left;
	margin: 20px auto 0px; 
	border-spacing: 0px; 
	border-collapse: collapse;"
}

.menu-height1 tr{
	align:left;
	height:40; 
	border-top: 1px solid #cccccc; 
	border-bottom: 1px solid #cccccc;"
}

.menu-height1 td{
	 width:100; 
	 bgcolor:#eeeeee;
	 text-align: center; 
}
.bott-button{
	width: 100%; 
	margin: 0px auto; 
	border-spacing: 0px;"
}

.bott-button tr{
	 height:45;
}

.bott-button td{
	 align:center; 
}

.btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
}

.menu-height1 .boxTF{
	background: white;
	border-color: #787878;
	border-width: 1px;
	height: 27px;
	align:center;
	width: 95%; 

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

    function check() {
        var f = document.employeeForm;

        var str = f.emName.value;
        if(!str) {
            alert("????????? ???????????????. ");
            f.emName.focus();
            return;
        }

    	str = f.ptCode.value;
        if(!str) {
            alert("????????? ???????????????. ");
            f.ptCode.focus();
            return;
        }
        
        str = f.emBirth.value;
        if(!str) {
            alert("??????????????? ???????????????. ");
            
            f.emBirth.focus();
            return;
        }
        
        str = f.hireDate.value;
        if(!str) {
            alert("???????????? ???????????????. ");
            f.hireDate.focus();
            return;
        }

    	f.action="<%=cp%>/employee/${mode}";

        f.submit();
    }
    
// ???????????? ?????? ?????? ????????????    
$(function(){
	$("#btnCategoryUpdate").click(function(){
		//??? reset
		$("form[name=addCategoryForm]").each(function(){
			this.reset();
		});
		
		$("#category-dialog").dialog({
			  modal: true,
			  height: 300,
			  width: 450,
			  title: '????????????',
			  close : function(event, ui) {
			}
		});
	});
});

// ???????????? ?????? ??????
$(function() {
	$("#btnCategorySendOk").click(function() {

		if(! $("#form-category").val()){
			$("#form-category").focus();
			return false;
		}
		
		var query = $("form[name=addCategoryForm]").serialize();
		var url = "<%=cp%>/employee/catecreate";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state =data.state;
				if(state == "true"){
					var page ="${page}";
					location.href="<%=cp%>/employee/update?page="+page+"&emCode=${dto.emCode}&emcheck=${emcheck}";
				}
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
	});	
});

//??? ??????
$(function() {
	$("#btnCategorySendCencel").click(function() {
		$("#category-dialog").dialog("close");
	});
});


</script>



<!-- Main -->
<div id="adminpage">
				<div class="trainandtime">
					<a href="<%=cp%>/employee/list">????????????</a> <span>|</span> <a href="<%=cp%>/admin/crewManage/list">????????????</a>
				</div>
	<!-- Main -->
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">
			

				<!-- ?????? ?????? -->
				<div class="9u skel-cell-important">
				<section>
					<header>
						<h2>${mode=='update'?'??????????????????':'????????????'}</h2>
					</header>
					
					<div>
						<form name="employeeForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
							<table class="menu-height1" >
								<c:if test="${mode=='update'}">
									<tr style="border-top: 1px solid #cccccc;">
										<td>??????</td>
										<td style="padding: 10px; text-align: left;">
											<input type="text" name="emCode" style="width: 25%;" value="${dto.emCode}" readonly="readonly">
										</td>
									</tr>
								</c:if>
								<tr style="border-top: 1px solid #cccccc;">
									<td>??????</td>
									<td style="padding: 10px; text-align: left;">
										<c:if test="${mode =='create'}">
											<input type="text" name="emName" maxlength="100" class="boxTF" style="width: 25%;" value="${dto.emName}">
										</c:if> <c:if test="${mode =='update'}">
											<input type="text" name="emName" maxlength="100" class="boxTF" style="width: 25%;" value="${dto.emName}" readonly="readonly">
										</c:if>
									</td>
								</tr>
								<tr style="border-top: 1px solid #cccccc;">
									<td>??????</td>
									<td style="padding: 10px; text-align: left;">
										<select name="ptCode" class="selectField">
											<c:forEach var="pt" items="${ptCodelist}">
												<option value="${pt.ptCode}" ${dto.ptCode == pt.ptCode ?"selected='selected'":""}>${pt.ptCategory}</option>
											</c:forEach>
										</select>
										<c:if test="${mode=='update'}">
											<button type="button" class="btn" id="btnCategoryUpdate">?????? ??????</button>
										</c:if>
									</td>
								</tr>

								<tr style="border-top: 1px solid #cccccc;">
									<td>????????????</td>
									<td style="padding: 10px; text-align: left; ">
										<c:if test="${mode =='create'}">
											<input type="text" name="emBirth" maxlength="10" class="boxTF" style="width: 25%;" value="${dto.emBirth}">
										</c:if> 
										<c:if test="${mode =='update'}">
											<input type="text" name="emBirth" maxlength="10" class="boxTF" style="width: 25%;" value="${dto.emBirth}" readonly="readonly">
										</c:if>
									</td>
								</tr>

								<tr style="border-top: 1px solid #cccccc;">
									<td>?????????</td>
									<td style="padding: 10px; text-align: left;">
										<c:if test="${mode =='create'}">
											<input type="text" name="hireDate" maxlength="10" class="boxTF" style="width: 25%;" value="${dto.hireDate}">
										</c:if> <c:if test="${mode =='update'}">
											<input type="text" name="hireDate" maxlength="10" class="boxTF" style="width: 25%;" value="${dto.hireDate}" readonly="readonly">
										</c:if>
									</td>
								</tr>

								<c:if test="${mode=='update'}">
									<tr style="border-top: 1px solid #cccccc;">
										<td>????????????</td>
										<td style="padding: 10px; text-align: left;">
										<select name="emcheck"class="selectField">
												<option value="1" ${dto.emcheck == 1 ?"selected='selected'":""}>??????</option>
												<option value="0" ${dto.emcheck == 0 ?"selected='selected'":""}>??????</option>
										</select>
									</td>
									</tr>
								</c:if>
							</table>

							<table
								style="width: 100%; margin: 0px auto; border-spacing: 0px;">
								<tr height="45">
									<td align="center">
										<button type="submit" class="btn" onclick="check();">${mode=='update'?'????????????':'????????????'}</button>
										<button type="reset" class="btn">????????????</button>
										<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/employee/list?emcheck=${emcheck}';">${mode=='update'?'????????????':'????????????'}</button>
										<c:if test="${mode=='update'}">
											<input type="hidden" name="page" value="${page}">
											<input type="hidden" name="emcheck" value="${emcheck }">
										</c:if>	
									</td>
								</tr>
							</table>
						</form>
					</div>

 					<div id="category-dialog"  style="display: none; text-align: center; ">
 					<form name="addCategoryForm">
					<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
	 					<tr>
			      			<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
								<label style="font-weight: 900; vertical-align: middle;">????????? ??????</label>
							</td>
							<td style="padding: 0 0 15px 15px;">
		       					<p style="margin-top: 1px; margin-bottom: 5px;">
							   		<input type="text" name="ptCategory" id="form-category" maxlength="100" class="boxTF">
							    </p>
						    	<p class="help-block">* ????????? ?????? ?????????.</p>
							</td>
						</tr>
							
						<tr height="45">		
							<td align="center" colspan="2"> 
 								<button type="button" class="btn" id="btnCategorySendOk" style="width: 50px; margin-left: 10px;">??????</button>
 								<button type="button" class="btn" id="btnCategorySendCencel" style="width: 90px; margin-left: 10px;">?????? ??????</button>
							</td>
						</tr>
	 					</table>
 					</form>
 					</div>
 				</section>
			</div>
			<!-- /???????????? -->
		
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->
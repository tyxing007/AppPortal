<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<link href="${ctx}/static/bootstrap/additions/wysihtml5/bootstrap-wysihtml5.css" type="text/css" rel="stylesheet" />
	<link href="${ctx}/static/bootstrap/additions/jasny/jasny-bootstrap.min.css" type="text/css" rel="stylesheet" />
	
	<script src="${ctx}/static/bootstrap/additions/wysihtml5/wysihtml5-0.3.0.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/bootstrap/additions/wysihtml5/bootstrap3-wysihtml5.js" type="text/javascript"></script>
	<script src="${ctx}/static/bootstrap/additions/wysihtml5/locales/bootstrap-wysihtml5.zh-CN.js" type="text/javascript"></script>
    <script src="${ctx}/static/bootstrap/additions/jasny/jasny-bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
<div class="row">
		<div class="col-md-2">
			<%@ include file="nav.jsp"%>
		</div>	
		<div class="col-md-10 ">
	<div class="page-header">
		<h2>修改帖子信息</h2>
	</div>
	
	<form:form id="form" method="post" modelAttribute="invitationReply" cssClass="form-horizontal" action="${ctx}/mgr/invitation/reply/update"  enctype="multipart/form-data">
		<form:hidden path="id" />
		<form:hidden path="invitationId" value="${invitation.id}"/>
		<jsp:include page="reply_form.jsp"/>
		<div class="form-group">
		<label class="col-sm-2 control-label"></label>
			<div class="col-sm-10">
			<input type="submit" id="onsubmit" class="hide"/>
			<input  value="提交"  class="btn btn-primary" id="submit"  type="button"/>
			<input id="cancel_btn" class="btn" type="button" value="返回" onclick="history.back()"/>
			</div>
		</div>
	</form:form>
	<script type="text/javascript">
	function deleteoldpic(id){
		if(confirm("确定要删除吗?")){ 
           $.ajax({
	         url: "${ctx}/mgr/invitation/reply/"+id+"/delpic",
	         type: 'DELETE',
	         async:false,
	         contentType: "application/json;charset=UTF-8"
	       })
	       .done(function( html ) {
	    	   $("#dispic_"+id).remove();
	       }).fail( function(jqXHR, textStatus){
	    	  alert("删除失败jqXHR="+jqXHR+"textStatus="+textStatus);
	   });
     }
   }
	
	$(function(){
		$(".display").hide();
		$("#submit").click(function(){
			var pic=$('input[name="choose"]:checked').val();
			if(pic=='picFile'){
				$("#picUrl").remove();
			}else if(pic=='picUrl'){
				$("#picFile").html("<input class='input-file' name='fileInput' id='fileInput' type='file'>");
			}
			$("#onsubmit").trigger("click"); 
		});
	})
	
	</script> 	
	</div>
	</div>
</body>
</html>
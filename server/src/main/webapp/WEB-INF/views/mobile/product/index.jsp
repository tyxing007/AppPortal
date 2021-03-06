<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
  <head>
    <meta charset="UTF-8">
    <title>企业产品</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

  </head>
  <body>
    <header class="bar bar-nav">	
    	    <a class="icon icon-left-nav pull-left" style="font-size:17px;padding-top:15px" href="javascript:go();">返回</a>
      <h1 class="title">企业产品</h1>
    </header>

    <div class="content">
    <ul class="table-view" style="margin-top: 0px" id="table-view">
        <li class="table-view-divider">产品列表</li>
	<c:forEach var="product" items="${products.content}">
			  <li class="table-view-cell media">
			    <a  href="javascript:turn(${product.id});" style="padding-right:10px;">
			      <img class="media-object pull-left" width="80px" height="80px" src="${product.thumb}">
			      <div class="media-body">
			      	${product.title}
			        <p>时间：${fn:substring(product.crtDate,0,10)}</br>产品简介：${product.intro}</p>
			      </div>	
			      </a>
			  </li>
		  </c:forEach>
      </ul>
     <div style="padding: 14px 40px;">
     	<input type="hidden" id="UID" name="UID" value="${UID}"/>
	    <button class="btn btn-block btn-primary" style="background-color: #f8f9fa;color:black;border: 1px solid #ccc;" onclick="more()">点击加载更多</button>
	 </div>
    </div>
   <script type="text/javascript">
   function turn(id)
   {
   	var url = "<%=request.getContextPath()%>/m/product/"+id;
   	location.href = url;
   }
   function go()
   {
   	var uid = $("#UID").val();
   	var url = "<%=request.getContextPath()%>/m/index?uid="+uid;
   	location.href = url;
   }
   
		var pn =1;
		function more(){
			pn = pn+1;
			var UID = $("#UID").val();
			var s="";
			$.ajax({
				url: '<%=request.getContextPath()%>/m/product/list?UID='+UID+'&pageNum='+pn, 
				type: 'GET',
				contentType: "application/json;charset=UTF-8",
				dataType: 'text',
				success: function(data){
					var parsedJson = $.parseJSON(data);
					jQuery.each(parsedJson, function(index, itemData) {
							var strDate = itemData.crtDate.substring(0,10);
							s="<li class='table-view-cell media'><a  data-transition='slide-in' href='javascript:turn("+itemData.id+");' style='padding-right:10px;'>"+
							"<img class='media-object pull-left' width='80px' height='80px' src='"+itemData.thumb+"'>"+
							"<div class='media-body'>"+itemData.title+"<p>时间："+strDate+"</br>产品简介："+itemData.intro+"</p></div></a></li>";
							 $("#table-view").append(s); 
					});
				}
			});

		}
	
	</script>
  </body>
</html>


<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>产品管理</title>
</head>

<body>
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success">
			<button data-dismiss="alert" class="close">×</button>${message}</div>
	</c:if>
	<div class="btn-group pull-right" style="margin-bottom:8px">
		<a class="btn btn-primary" href="${ctx}/product/create"><i class="icon-plus-sign icon-white"></i> 创建</a>
		<a class="btn btn-danger"><i class="icon-trash icon-white"></i> 删除</a>
	</div>
	
	<table
		class="table table-striped table-bordered table-condensed table-hover">
		<thead>
			<tr>
				<th>图片</th>
				<th>产品名称</th>
				<th>代码</th>
				<th>类别</th>
				<th>管理</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${products.content}" var="product">
				<tr>
					<td><a href="${ctx}/product/${product.id}" class="thumbnail"><img
							width="100" height="80"
							src="${ctx}/${product.pictures[0].url}?100*80" /></a></td>
					<td><a href="${ctx}/product/${product.id}">${product.name}</a></td>
					<td>${product.code}</td>
					<td>${product.catalog.name}</td>
					<td><a class="btn btn-danger" href="${ctx}/product/delete/${catalog.id}"><i class="icon-trash icon-white"></i> 删除</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<tags:pagination page="${products}" paginationSize="5" />

</body>
</html>

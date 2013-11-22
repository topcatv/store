<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>产品类别管理</title>
</head>

<body>
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success">
			<button data-dismiss="alert" class="close">×</button>${message}</div>
	</c:if>

	<tags:sort />

	<table
		class="table table-striped table-bordered table-condensed table-hover">
		<thead>
			<tr>
				<th>产品类别</th>
				<th>管理</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${catalogs.content}" var="catalog">
				<tr>
					<td><a href="${ctx}/product/catalog/${catalog.id}">${catalog.name}</a></td>
					<td><a class="btn btn-danger" href="${ctx}/product/catalog/delete/${catalog.id}"><i class="icon-trash icon-white"></i> 删除</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<tags:pagination page="${catalogs}" paginationSize="5" />

	<a class="btn" href="${ctx}/product/catalog/create">创建类别</a>
</body>
</html>

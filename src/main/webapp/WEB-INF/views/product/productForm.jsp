<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>产品管理</title>
</head>

<body>
	<form id="inputForm" action="${ctx}/product" method="post" class="form-horizontal">
		<input type="hidden" name="id" value="${product.id}"/>
		<fieldset>
			<legend><small>产品管理</small></legend>
			<div class="form-group">
				<label class="control-label col-sm-2">产品名:</label>
				<div class="col-sm-10">
					<input type="text" id="name" value="${product.name}" class="form-control required" name="name" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">产品快捷码:</label>
				<div class="col-sm-10">
					<input type="text" name="code" value="${product.code}" class="form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">产品描述:</label>
				<div class="col-sm-10">
					<textarea name="description" class="form-control">${product.description}</textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">产品类别:</label>
				<div class="col-sm-10">
					<select name="catalog.id" class="form-control">
						<c:forEach items="${catalogs}" var="catalog">
						<option value="${catalog.id}">${catalog.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3">
					<input id="submit_btn" class="btn btn-primary" type="submit" value="提交"/>&nbsp;	
					<input id="cancel_btn" class="btn btn-default" type="button" value="返回" onclick="history.back()"/>
				</div>
			</div>
		</fieldset>
	</form>
	
	<script>
		$(document).ready(function() {
			//聚焦第一个输入框
			$("#name").focus();
			//为inputForm注册validate函数
			$("#inputForm").validate();
		});
	</script>
</body>
</html>

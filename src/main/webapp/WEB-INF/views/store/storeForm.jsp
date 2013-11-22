<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>入库</title>
<script type="text/javascript" src="${ctx}/static/store.js"></script>
</head>

<body>
	<table id="product_table"
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
					<td><img width="100" height="80"
						src="${ctx}/${product.pictures[0].url}" /> <input type="hidden"
						value="${product.id}" /></td>
					<td>${product.name}</td>
					<td>${product.code}</td>
					<td>${product.catalog.name}</td>
					<td><a class="btn btn-primary" href="#" role="button"
						data-toggle="modal"><i class="icon-download-alt icon-white"></i>
							入库</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<tags:pagination page="${products}" paginationSize="5" />
	
	<table id="store_table"
		class="table table-striped table-bordered table-condensed table-hover">
		<thead>
			<tr>
				<th>数量</th>
				<th>价格</th>
				<th>入库时间</th>
			</tr>
		</thead>
		<tbody>
			
		</tbody>
	</table>

	<div id="inStoreModal" class="modal hide fade">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h3>商品入库</h3>
		</div>
		<form id="inputForm" action="${ctx}/store.json" method="post"
			class="form-horizontal">
			<div class="modal-body">
				<input type="hidden" name="product.id"/>
				<div class="control-group">
					<label class="control-label">商品图片:</label>
					<div class="controls">
						<img alt="" src="" width="150" height="90"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">商品名称:</label>
					<div class="controls">
						<input type="text" id="name" value=""
							class="form-control required" name="product.name" disabled/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">商品代码:</label>
					<div class="controls">
						<input type="text" id="code" value=""
							class="form-control required" name="product.code" disabled/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">入库数量:</label>
					<div class="controls">
						<input type="text" name="amount" value=""
							class="form-control required" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">入库价格:</label>
					<div class="controls">
						<input type="text" name="inPrice" value=""
							class="form-control required" />
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<input id="cancel_btn" class="btn btn-default" type="button"
					value="关闭" data-dismiss="modal" />&nbsp; <input id="submit_btn"
					class="btn btn-primary" type="submit" value="提交" />
			</div>
		</form>
	</div>
</body>
</html>

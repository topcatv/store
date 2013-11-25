<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>订单</title>
<script type="text/javascript" src="${ctx}/static/order.js"></script>
</head>

<body>
	<form id="inputForm" action="${ctx}/order" method="post"
		class="form-horizontal">
		<div class="row">
			<input type="hidden" name="id" />
			<div class="control-group">
				<label class="control-label">订单号:</label>
				<div class="controls">
					<input type="text" id="orderNum" value="${orderList.orderNum}"
						class="form-control required" name="orderNum" readonly="readonly" />
				</div>
			</div>
		</div>
		<div class="btn-group pull-right" style="margin-bottom: 8px">
			<a class="btn btn-primary" href="#"><i
				class="icon-plus-sign icon-white"></i> 添加商品</a> <a
				class="btn btn-success" href="#"><i
				class="icon-check icon-white"></i> 保存订单</a>
		</div>
		<table id="order_table"
			class="table table-striped table-bordered table-condensed table-hover">
			<thead>
				<tr>
					<th>图片</th>
					<th>商品名</th>
					<th>数量</th>
					<th>售价</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</form>
	<div id="inStoreModal" class="modal hide fade">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h3>添加商品</h3>
		</div>
		<div class="modal-body">
			<table id="store_table"
				class="table table-striped table-bordered table-condensed table-hover">
				<thead>
					<tr>
						<th>选择</th>
						<th>图片</th>
						<th>产品名称</th>
						<th>代码</th>
						<th>类别</th>
						<th>库存数量</th>
						<th>进价</th>
						<th>售价</th>
						<th>数量</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<input id="cancel_btn" class="btn btn-default" type="button"
				value="关闭" data-dismiss="modal" />&nbsp; <input id="submit_btn"
				class="btn btn-primary" type="button" value="提交" />
		</div>
	</div>
</body>
</html>

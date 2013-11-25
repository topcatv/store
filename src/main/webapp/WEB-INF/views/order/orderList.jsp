<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>订单管理</title>
</head>

<body>
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success">
			<button data-dismiss="alert" class="close">×</button>${message}</div>
	</c:if>
	<div class="btn-group pull-right" style="margin-bottom: 8px">
		<a class="btn btn-primary" href="${ctx}/order/create"><i
			class="icon-plus-sign icon-white"></i> 创建</a>
	</div>

	<table id="ol_table"
		class="table table-striped table-bordered table-condensed table-hover">
		<thead>
			<tr>
				<th>订单号</th>
				<th>订单产品</th>
				<th>创建时间</th>
				<th>创建人</th>
				<th>管理</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${orders.content}" var="orderlist">
				<tr>
					<td><input name="ol_id" type="hidden" value="${orderlist.id}" /><a href="#" class="thumbnail">${orderlist.orderNum}</a></td>
					<td>
						<ul>
							<c:forEach items="${orderlist.orders}" var="order">
								<li>${order.store.product.name}</li>
							</c:forEach>
						</ul>
					</td>
					<td>${orderlist.createDate}</td>
					<td>${orderlist.operator.name}</td>
					<td><a class="btn btn-danger"
						href="${ctx}/order/delete/${orderlist.id}"><i
							class="icon-trash icon-white"></i> 删除</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<tags:pagination page="${orders}" paginationSize="5" />

	<div id="inStoreModal" class="modal hide fade">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h3>订单商品</h3>
		</div>
		<div class="modal-body">
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
		</div>
		<div class="modal-footer">
			<input id="cancel_btn" class="btn btn-default" type="button"
				value="关闭" data-dismiss="modal" />
		</div>
	</div>
	
	<script type="text/javascript">
	
	$(document).ready(function() {
		$("#ol_table tr").click(function(){
			var id = $(this).find("input:hidden").val();
			console.log(id);
			$.getJSON(context+"/order/"+id+".json",function(data){
				var orders = data.orderList.orders;
				$("#order_table tbody").empty();
				$.each(orders, function(index, order){
					var trDom = "<tr>" +
					"<td><img width='180' heigh='100' src='" + order.store.product.pictures[0].url + "' /></td>"+
					"<td>" + order.store.product.name + "</td>"+
					"<td>" + order.amount + "</td>"+
					"<td>" + order.sellPrice + "</td>";
					$("#order_table tbody").append(trDom);
				});
				$("#inStoreModal").modal("show");
			});
		});
	});
	</script>
</body>
</html>

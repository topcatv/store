$(document).ready(function() {
	// 聚焦第一个输入框
	// $("#name").focus();
	// 为inputForm注册validate函数
	$("#inputForm").validate();
	
	$(".btn-group .btn-primary").click(function(){
		$.getJSON(context + "/order/store.json", function(data) {
			$("#store_table tbody").empty();
			$.each(data.stores, function(index, store) {
				var trDom = "<tr>" +
						"<td><input type='checkbox' name='id' value='" + store.id + "' /></td>" +
						"<td><img width='180' heigh='100' src='" + context + "/"+store.product.pictures[0].url+"' /></td>" +
						"<td>" + store.product.name + "</td>" +
						"<td>" + store.product.code + "</td>" +
						"<td>" + store.product.catalog.name + "</td>" +
						"<td>" + store.amount + "</td>" +
						"<td>" + store.inPrice + "</td>" +
						"<td><input type='text' class='input-mini' name='sellPrice' /></td>" +
						"<td><input type='text' class='input-mini' name='sellCount' /></td>" +
						"</tr>";
				$("#store_table tbody").append(trDom);
			});
			$("#inStoreModal").modal("show");
		});
	});
	
	$("#submit_btn").click(function(){
		var checked = $("#store_table input:checked");
		console.log(checked);
		checked.each(function(index, checkbox){
			var tr = $(checkbox).parent().parent();
			var id = $(checkbox).val();
			var img = tr.find("img").attr("src");
			var name = tr.find("td:eq(2)").html();
			var count = tr.find("input[name='sellCount']").val();
			var sellPrice = tr.find("input[name='sellPrice']").val();
			
			var trDom = "<tr>" +
			"<td><input type='hidden' name='orders[" + index + "].store.id' value='" + id + "'/><img width='180' heigh='100' src='" + img + "' /></td>"+
			"<td>" + name + "</td>"+
			"<td><input type='hidden' name='orders[" + index + "].amount' value='" + count + "'/>" + count + "</td>"+
			"<td><input type='hidden' name='orders[" + index + "].sellPrice' value='" + sellPrice + "'/>" + sellPrice + "</td>";
			$("#order_table tbody").append(trDom);
		});
		$("#inStoreModal").modal("hide");
	});
	
	$(".btn-group .btn-success").click(function(){
		$("#inputForm").submit();
	});

});
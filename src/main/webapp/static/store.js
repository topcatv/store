$(document).ready(function() {
	// 聚焦第一个输入框
	// $("#name").focus();
	// 为inputForm注册validate函数
	$("#inputForm").validate();

	$("tbody a").click(function(event) {
		event.preventDefault();
		var tr = $(this).parent().parent();
		$("#inStoreModal").modal("show");
		var form = $("#inputForm");
		var id = tr.find("input[type='hidden']").val();
		console.log(form.find("input[type='hidden']"));
		form.find("input[type='hidden']").val(id);
		form.find("img")
				.attr("src", tr.find("img").attr("src"));
		form.find("input[name='product.name']").val(
				tr.find("td:eq(1)").html());
		form.find("input[name='product.code']").val(
				tr.find("td:eq(2)").html());
	});
	$("#inputForm").submit(function(event) {
		event.preventDefault();
		$(this).ajaxSubmit({
			dataType : "json",
			success : function(data) {
				if (data.success) {
					Messenger().post({
						message : data.message,
						type : "success",
						hideAfter : 3
					});
					$("#inStoreModal").modal("hide");
				}
			}
		});
	});

	$("#product_table tr").click(function() {
		var tr = $(this);
		var id = tr.find("input[type='hidden']").val();
		$("#store_table tbody").empty();
		$.getJSON(context + "/store/" +id + ".json", function(data) {
			$.each(data.stores, function(index, store) {
				var trDom = "<tr><td>" + store.amount
						+ "</td><td>" + store.inPrice
						+ "</td><td>"
						+ store.createDate
						+ "</td></tr>";
				$("#store_table tbody").append(trDom);
			});
		});
	});
});
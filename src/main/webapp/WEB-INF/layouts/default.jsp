<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<title>QuickStart示例:<sitemesh:title /></title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link type="image/x-icon" href="${ctx}/static/images/favicon.ico"
	rel="shortcut icon">
<link href="${ctx}/static/bootstrap/2.3.2/css/bootstrap.min.css"
	type="text/css" rel="stylesheet" />
<link href="${ctx}/static/jquery-validation/1.11.1/validate.css"
	type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/default.css" type="text/css"
	rel="stylesheet" />
<link href="${ctx}/static/styles/font-awesome.min.css" type="text/css"
	rel="stylesheet" />
<link href="${ctx}/static/css/messenger.css" type="text/css"
	rel="stylesheet" />
<link href="${ctx}/static/css/messenger-future.css" type="text/css"
	rel="stylesheet" />
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js"
	type="text/javascript"></script>
<script
	src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js"
	type="text/javascript"></script>
<script src="${ctx}/static/bootstrap-filestyle.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/jquery.form.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/js/messenger.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	Messenger.options = {
	    extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
	    theme: 'block'
	};
	context = "${ctx}";
</script>
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->

<sitemesh:head />
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="span12">
				<%@ include file="/WEB-INF/layouts/header.jsp"%>
			</div>
		</div>
		<div class="row">
			<div class="span3">
				<ul class="nav nav-list well">
					<li class="nav-header">基础数据管理</li>
					<li><a href="${ctx}/product">产品管理</a></li>
					<li><a href="${ctx}/product/catalog">产品类别管理</a></li>
					<li class="nav-header">库存管理</li>
					<li><a href="${ctx}/store">入库</a></li>
					<li><a href="#">出库</a></li>
					<li><a href="${ctx}/store">库存查询</a></li>
					<li class="nav-header">订单管理</li>
					<li><a href="${ctx}/order">订单查询</a></li>
					<li class="divider"></li>
					<li><a href="#">帮助</a></li>
				</ul>
			</div>
			<div class="span9">
				<sitemesh:body />
			</div>
		</div>
		<div class="row">
			<div class="span12">
				<%@ include file="/WEB-INF/layouts/footer.jsp"%>
			</div>
		</div>
	</div>
	<script src="${ctx}/static/bootstrap/2.3.2/js/bootstrap.min.js"
		type="text/javascript"></script>
</body>
</html>
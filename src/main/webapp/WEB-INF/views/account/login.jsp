<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>登录页</title>
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
<link href="${ctx}/static/styles/font-awesome.min.css" type="text/css"
	rel="stylesheet" />
<link href="${ctx}/static/styles/default.css"
	type="text/css" rel="stylesheet" />
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js"
	type="text/javascript"></script>
<script
	src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js"
	type="text/javascript"></script>
<script src="${ctx}/static/bootstrap-filestyle.min.js"
	type="text/javascript"></script>
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->

</head>

<body>
<div class="container">
	<div class="span4 offset4 well">
		<form id="loginForm" action="${ctx}/login" method="post" class="form-horizontal">
		<legend>请登陆</legend>
		<%
		String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
		if(error != null){
		%>
			<div class="alert alert-error input-medium controls">
				<button class="close" data-dismiss="alert">×</button>登录失败，请重试.
			</div>
		<%
		}
		%>
		<div class="control-group-merged">
			<div class="control-group">
				<div class="input-prepend">
					<span class="add-on"><i class="icon-user"></i></span><input style="height: 30px" type="text" id="username" placeholder="用户名" name="username" value="${username}" class="form-control required"/>
				</div>
			</div>
			<div class="control-group">
				<div class="input-prepend">
					<span class="add-on"><i class="icon-lock"></i></span><input style="height: 30px" type="password" id="password" placeholder="密码" name="password" class="form-control required"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="checkbox">
				<input type="checkbox" id="rememberMe" name="rememberMe" class="uniform"> 记住我
			</label>
		</div>
		<div class="control-group">
			<input id="submit_btn" class="btn btn-primary" type="submit" value="登录"/> <a class="btn" href="${ctx}/register">注册</a>
		 	<span class="help-block">(管理员: <b>admin/admin</b>, 普通用户: <b>user/user</b>)</span>
		</div>
		</form>
	</div>
</div>
<script src="${ctx}/static/bootstrap/2.3.2/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script>
		$(document).ready(function() {
			$("#loginForm").validate();
			$(".well").css({
				'margin-top': function () {
					return ($(this).height() / 2);
				}
			});
		});
	</script>
</body>
</html>

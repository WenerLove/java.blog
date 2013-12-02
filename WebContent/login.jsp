<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="top.jsp"%>
<!-- 主内容 -->

<section id="login-page" class="page-part narrow-part">

	<div class="section-header page-header">
		<h1>用户登陆</h1>
	</div>

	<form id="main-form" role="form" method="post" action="deal_login.jsp">

		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-user"></i></span> <input
					type="text" class="form-control" name="account" required="required"
					placeholder="用户名">
			</div>
		</div>
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-key"></i></span> 
				<input
					type="password" class="form-control" name="password"
					required="required" placeholder="密码">
			</div>
		</div>

		<div class="form-group register-field with-dec">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-arrows-v"></i>
				</span> <input type="password" class="form-control" name="repeat_password"
					placeholder="请再次输入密码">
			</div>

			<button type="button" class="close dec-tr register-off-btn"
				aria-hidden="true">&times;</button>
		</div>
		<div class="form-group">
			<button type="submit"
				class="login-btn btn btn-default col-sm-4 col-sm-offset-1">登录</button>
			<button class="register-btn btn btn-primary col-sm-4 col-sm-offset-1">注册</button>
		</div>
	</form>

</section>


<script src="scripts/login.js"></script>

<!-- /主内容 -->
<%@include file="bottom.jsp"%>

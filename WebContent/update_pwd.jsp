<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>

<%@include file="top.jsp"%>

<section class="page-part narrow-part">
	<div class="page-header section-header">
		<h1>修改密码</h1>
	</div>
	<form id="main-form" 
		class="form-horizontal" 
		role="form" 
		method="post"
		action="deal_update_pwd.jsp">
		
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-key"></i></span> 
				<input type="password" class="form-control" name="old_password" required="required"
					placeholder="请输入当前密码">
			</div>
		</div>
		
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-terminal"></i></span> 
				<input type="password" class="form-control" name="repeat_password" required="required"
					placeholder="请输入新密码">
			</div>
		</div>
		
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-arrows-v"></i></span> 
				<input type="password" class="form-control" name="password" required="required"
					placeholder="请再次输入新密码">
			</div>
		</div>
		
		<div class="form-group">
			<button type="submit"
				class="btn btn-primary col-sm-3 col-sm-offset-2">提交</button>
			<button type="reset" class="btn btn-default col-sm-3 col-sm-offset-2">重置</button>
		</div>
	</form>
	
</section>
<script src="scripts/update_pwd.js"></script>
<%@include file="bottom.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>

<%@ include file="conn/conn.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>博客园-</title>
<%@include file="assets.html"%>
</head>

<body>
	<!-- 主导航 -->
	<nav class="navbar-main navbar navbar-inverse navbar-fixed-top"
		role="navigation">
		<!-- Brand -->
		<div class="navbar-header">
			<a class="navbar-brand" href="index.jsp"><i class="fa fa-home"></i>
				博客园</a>
		</div>

		<ul class="nav navbar-nav">

			<c:if test="${u5.isLogin()}">
				<li><a href="edit_article.jsp"><i class="fa fa-edit"></i>
						添加文章</a></li>
				<li><a href="article_list.jsp"><i class="fa fa-files-o"></i>
						阅览文章</a></li>

				<li class="dropdown">
					<a data-toggle="dropdown" class="dropdown-toggle" data-toggle="dropdown" href="#">
						<i class="fa fa-gear"></i> 设置<span class="caret"></span>
					</a>
					<ul class="dropdown-menu" role="menu">
						
						<li><a href="profile.jsp?id=<c:out value="${u5.getCurrentUser().getId()}" />">
						<i class="fa fa-user"></i>
								个人信息</a>
						</li>
						
						<li><a href="update_pwd.jsp"><i class="fa fa-certificate"></i>
								修改密码</a>
						</li>
					</ul>
				</li>
			</c:if>

			<c:if test="${u5.isAdministrator()}">
				<li><a href="user_list.jsp">管理用户</a></li>
			</c:if>

		</ul>

		<c:if test="${!u5.isLogin()}">
			<p class="navbar-text">
				<a href="login.jsp" class="navbar-link">登录</a> 后启用更多功能
			</p>
		</c:if>

		<c:if test="${u5.isLogin()}">
			<div class="col-sm-5 navbar-right">
				<%@include file="part/query_article_form.jsp"%>
			</div>
		</c:if>

		<div class="nav navbar-nav navbar-right nav-user-op">

			<c:if test="${!u5.isLogin()}">
				<a href="login.jsp" class="btn btn-default navbar-btn btn-xs">登陆</a>
				<a href="login.jsp?register"
					class="btn btn-primary navbar-btn btn-xs">注册</a>
			</c:if>
			<c:if test="${u5.isLogin()}">
				<a href="deal_logout.jsp" class="btn btn-default navbar-btn btn-xs">
					注销 <c:out value="${u5.getCurrentUser().getAccount()}" />
				</a>
			</c:if>
		</div>

	</nav>

	<!-- /主导航 -->

	<div class="container container-main">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<%@include file="/WEB-INF/conn.jsp"%>
<%
	User user = new User();
	user.setAccount((String)request.getParameter("account"));
	user.setPassword((String)request.getParameter("password"));
	user.setIp(request.getRemoteAddr());
	
	if(u5.isAccountExists(user.getAccount()))
		u5.sendError(ErrorMessage.AccountAlreadyExists);
	else{
		try{
			userDao.create(user);
			u5.Login(user.getAccount(), user.getPassword());
			response.sendRedirect("index.jsp");
		}catch(SQLException ex){
			u5.Logout();// 登陆失败会注销一次当前用户
			u5.sendError(ErrorMessage.RegisterFailed);
		}
	}
%>

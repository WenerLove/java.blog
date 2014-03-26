<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<%@include file="/WEB-INF/conn.jsp"%>
<%
	if (u5.requireLogin())
	{
		String sql;
		//String p = request.getParameter("newpwd");
		//sql="update adminuser set regpwd='"+p+"' where regname='"+session.getAttribute("username")+"'";
		String password = request.getParameter("password");
		String oldPassword = request.getParameter("old_password");
		
		User user = u5.getCurrentUser();
		if(false == user.getPassword().equals(oldPassword))
		{
			u5.sendError(ErrorMessage.PasswordIncorrect);
		}else if(password != null && password.length() > 3)
		{
			user.setPassword(password);
			userDao.update(user);
			u5.Logout();
			response.sendRedirect("login.jsp");
		}else{
			u5.sendError(ErrorMessage.PasswordIncorrect);
		}
	}
%>

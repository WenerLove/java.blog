<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<%@ page import="java.util.*" %>
<%@include file="/WEB-INF/conn.jsp"%>
<%
	
	String account=request.getParameter("account");
	String password=request.getParameter("password");
	
	u5.Login(account, password);
	
	if(u5.isLogin())
		//u5.GoBack();
		response.sendRedirect("index.jsp");
	else
		u5.sendError(ErrorMessage.LoginFailed);
	
	//String sql="select * from adminuser where regname='"+name+"' and regpwd='"+pwd+"'";
	//out.print(sql);
	//ResultSet rs=stm.executeQuery(sql);
	/*
	if(rs.next())
	{
		String fig=String.valueOf(rs.getInt("fig"));
		session.setAttribute("fig",fig);
		session.setAttribute("username",name);
		out.print((String)session.getAttribute("username"));
		response.sendRedirect("index.jsp");
	}else
	{
		response.sendRedirect("error.jsp");
	}
	*/
%>
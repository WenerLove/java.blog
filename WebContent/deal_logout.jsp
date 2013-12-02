<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<%@include file="conn/conn.jsp" %>
<%
	u5.Logout();
	response.sendRedirect("index.jsp");
%>
<%@page import="com.j256.ormlite.dao.Dao"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="me.wener.practice.blog.*" %>


<%
	// 预定义变量
	
	U5 u5 = new U5( request, response, session);
	
	pageContext.setAttribute("u5",u5);
	
	Dao<Article,Integer> articleDao = u5.getArticleDao();
	Dao<Comment,Integer> commentDao = u5.getCommentDao();
	Dao<User,Integer> userDao = u5.getUserDao();
	
	pageContext.setAttribute("articleDao",articleDao);
	pageContext.setAttribute("commentDao",commentDao);
%>
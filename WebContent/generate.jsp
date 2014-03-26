<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="me.wener.practice.blog.*" %>
<%@include file="/WEB-INF/conn.jsp"%>
<pre>
<%
	Article article;
	User user;
	
	for(int i = 0; i < 20; i ++)
	{
		user = new User();
		user.setAccount(String.format("account_%d", i));
		user.setPassword(user.getAccount());
		user.setRealname(String.format("wener #%d", i));
		user.setEmail(String.format("wener_%d_@wener.com",i));
		
		userDao.create(user);
		
		for(int j = 0; j < i; j ++)
		{
			article = new Article();
			article.setAuthor(user.getAccount());
			article.setTitle(String.format("title %d for user %d", i, j));
			article.setContent(String.format("Content %d write by %d", i, j));
					
			articleDao.create(article);
		}
	}
%>
</pre>

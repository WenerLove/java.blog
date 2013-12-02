<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>

<%@include file="conn/conn.jsp"%>

<%
	if(u5.requireLogin())
	{
		int id = U5.tryParseInt(request.getParameter("id"),-1);
		Article article = null;
		try{
			article = articleDao.queryForId(id);
		}catch(SQLException ex){}
		
		if(article == null)
		{
			u5.sendError(ErrorMessage.ArticleNotExists);
		}else if(u5.isAdministrator() || article.getAuthor().equals(u5.getCurrentUser().getAccount())){
			articleDao.delete(article);
			response.sendRedirect("article_list.jsp");
		}else{
			u5.sendError(ErrorMessage.RequireAdmin);
		}
		
	}
%>




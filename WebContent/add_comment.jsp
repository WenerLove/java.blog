<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="top.jsp"%>
<%
	Article article = null;
	Comment comment = null;
	try{
		article = articleDao.queryForId(U5.tryParseInt(request.getParameter("article_id")));
	}catch(SQLException ex){}
	
	String content = request.getParameter("content");
	if(!u5.isLogin())
		u5.sendError(ErrorMessage.RequireLogin);
	else if(article == null)
		u5.sendError(ErrorMessage.ArticleNotExists);
	else if(content == null || content.length() == 0)
		u5.sendError(ErrorMessage.NoCommentContent);
	else{
		User user = u5.getCurrentUser();
		comment = new Comment();
		comment.setUserAccount(user.getAccount());
		comment.setArticleId(article.getId());
		comment.setContent(content);
		
		try{
			commentDao.create(comment);
			String redirectTo = "showarticle.jsp?id=%d#ct-%d";
			redirectTo = String.format(redirectTo,article.getId(),comment.getId());
			
			response.sendRedirect(redirectTo);
		}catch(SQLException ex)
		{
			u5.sendError(ErrorMessage.UnknowError);
		}
	}
%>
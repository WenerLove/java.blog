
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<%request.setCharacterEncoding("UTF-8");%>
<%@include file="conn/conn.jsp"%>

<%
u5.requireLogin();
if(u5.isLogin())
{
	String title=request.getParameter("txt_title");
	String content=request.getParameter("content");
	
	User user = u5.getCurrentUser();
	int articleId = -1;
	Article article = null;
	try{
		article = articleDao.queryForId(U5.tryParseInt(request.getParameter("id")));
	}catch(SQLException ex){}
	
	if(article == null)
	{
		article = new Article();
		article.setAuthor(user.getAccount());
	}else
		articleId = article.getId();
	
	article.setTitle(title);
	article.setContent(content);
	
	try{
		
		if(articleId >= 0)
			articleDao.update(article);
		else{
			article = articleDao.createIfNotExists(article);
			articleId = article.getId();
		}
		// 添加成功,跳转到该文章页面
		response.sendRedirect("showarticle.jsp?id="+articleId);
	}catch(SQLException ex){
		System.out.printf("添加文章失败: %s", ex.getMessage());
		
		u5.sendError(ErrorMessage.EditArticleFailed);
	}
	
	/*
	String pubtime=new java.util.Date().toLocaleString();

	String sql="Insert Into article (title,content,author,pubtime) Values ('"+title+"','"+content+"','"+author+"','"+pubtime+"')";
	out.print(sql);
	int n=0;
	n=stm.executeUpdate(sql);
	if(n>0){
	out.print("<script>alert('恭喜您，你的文章发表成功!!!');window.location.href='welcome.jsp';</script>");
	}
	else{
	out.print("<script>alert('对不起，添加操作失败!!!');window.location.href='welcome.jsp';</script>");
		}
	*/
}
%>

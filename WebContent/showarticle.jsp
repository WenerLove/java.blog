<%@page import="com.j256.ormlite.stmt.SelectArg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@include file="top.jsp"%>

<%
	String sid = request.getParameter("id");
	int id = Integer.parseInt(sid);
	String sql = "select * from article where id=" + id;

	//out.print(sql);
	//ResultSet rs = stm.executeQuery(sql);
	
	Article article = articleDao.queryForId(id);
	if(article == null)
		u5.sendError(ErrorMessage.ArticleNotExists);
	else
	{
	User author = u5.getArticleAuthor(article);
	
	pageContext.setAttribute("article",article);
	pageContext.setAttribute("author",author);
	
	Article prevArticle = null;
	Article nextArticle = null;
	List<Comment> commentList = null;
	if(article != null)
	{
		// 计算上一篇和下一篇文章
		prevArticle = articleDao
			.queryBuilder()
			.orderBy(Article.FIELD_ID, false)
			.where()
			.lt(Article.FIELD_ID, article.getId())
			.queryForFirst();
		nextArticle = articleDao
			.queryBuilder()
			.orderBy(Article.FIELD_ID, true)
			.where()
			.gt(Article.FIELD_ID, article.getId())
			.queryForFirst();
		//
		commentList = commentDao
			.queryBuilder()
			.orderBy(Comment.FIELD_PUBTIME, false)
			.where()
			.eq(Comment.FIELD_ARTICLE_ID, article.getId())
			.query()
			;
	}
	pageContext.setAttribute("prevArticle",prevArticle);
	pageContext.setAttribute("nextArticle",nextArticle);
	pageContext.setAttribute("commentList",commentList);

%>

<section class="page-part">
	
	<div class="section-header page-header">
		<h1><c:out value="${article.getTitle()}" /></h1>
	</div>
	<p class="text-center text-muted">
	作者 <span class="text-primary"><c:out value="${article.getAuthor()}" /></span> 
	于 <fmt:formatDate pattern="yyyy/mm/dd hh:MM" value="${article.getPubtime()}" /> 发表</p>
	
	<div class="blog-container text-2em indent-2em">
	<c:out value="${article.getContent()}" />
	</div>
	
	<!-- 显示上一篇和下一篇 -->
	<ul class="pager">
	
		<c:choose>
	    <c:when test="${prevArticle == null}">
	       <li class="previous disabled"><a href="#">&larr; 已经是第一篇</a></li>
	    </c:when>
	    <c:otherwise>
	       <li class="previous">
	       	<a href="?id=<c:out value="${prevArticle.getId()}" />">&larr; <c:out value="${prevArticle.getTitle()}" /></a>
	       </li>
	    </c:otherwise>
		</c:choose>
	  
	  	<c:choose>
	    <c:when test="${nextArticle == null}">
	       <li class="next disabled"><a href="#">已经是最后一篇 &rarr;</a></li>
	    </c:when>
	    <c:otherwise>
	       <li class="next">
	       	<a href="?id=<c:out value="${nextArticle.getId()}" />"><c:out value="${nextArticle.getTitle()}" /> &rarr;</a>
	       </li>
	    </c:otherwise>
		</c:choose>
	  
	  
	</ul>
	<!-- /显示上一篇和下一篇 -->
</section>

<section class="page-part">
	
	<div class="section-header page-header">
		<h2 class="text-left">评论</h2>
	</div>
	
	<c:if test="${u5.isLogin()}">
	<form id="main-form" role="form" method="post" action="add_comment.jsp">
	<input type="hidden" name="article_id" value="<%=article.getId() %>" />
	<div class="form-group">
		<textarea class="form-control" rows="3" name="content" required="required" placeholder="请输入评论内容"></textarea>
	</div>
	<div class="form-group">
		<span><%=u5.getCurrentUser().getAccount() %>: </span>
		<button type="submit" class="btn btn-primary pull-right">发表</button>
	</div>
	</form>
	</c:if>
	
	<c:if test="${!u5.isLogin()}">
	<div class="well well-sm">请先 <a href="login.jsp">登录</a> 再进行评论</div>
	</c:if>
	
	<!-- 显示评论列表 -->
	<ul class="list-group">
		<li class="list-group-item text-center">
		共有评论 <c:out value="${commentList == null? 0: commentList.size()}"/> 条
		</li>
		<c:forEach items="${commentList}" var="comment">
		<%
			Comment comment = (Comment)pageContext.getAttribute("comment");
			User user = u5.getCommentUser(comment);
			
		%>
		<li id="ct-<%=comment.getId() %>" class="list-group-item">
			<a href="profile.jsp?id=<%=user.getId() %>"><%=user.getAccount() %></a> 于 
			<small><%=U5.formatDate(comment.getPubtime()) %></small> 说到:
			<div >
			<%=comment.getContent() %>
			</div>
		</li>
		</c:forEach>
	</ul>
	
	<!-- /显示评论列表 -->
</section>

<%@include file="bottom.jsp"%>
<%} %>

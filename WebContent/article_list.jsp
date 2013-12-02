<%@page import="javax.naming.LimitExceededException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<%@page import="com.j256.ormlite.dao.CloseableIterator"%>
<%@page import="com.j256.ormlite.stmt.QueryBuilder"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@include file="top.jsp"%>

<section class="page-part">

	<div class="page-header section-header">
		<h1>查询文章</h1>
	</div>

	<%@include file="part/query_article_form.jsp" %>
	
	<!-- 显示文章列表 -->
<%
	int pageNo = U5.tryParseInt(request.getParameter("pageno"), 1);
	int prePage = U5.tryParseInt(request.getParameter("prepage"), 0);
	// 进行当前页面查询的 参数url 用来翻页的时候使用
	String baseUrl= String.format("?"); 
	
	prePage = prePage == 0 ? 10 : prePage;
	pageNo = pageNo < 1? 1: pageNo;// 页码不能小于等于0

	String keyword = request.getParameter("keyword");
	
	ArticleSearchBy by = ArticleSearchBy.TITLE;
	try{
		by = ArticleSearchBy.valueOf(request.getParameter("by").toUpperCase());
	}catch(NullPointerException ex){}// by 可能不存在
	catch(IllegalArgumentException ex){}// enum 可能找不到
	
	// 添加关键词到 url上
	if(keyword != null)
		baseUrl += String.format("keyword=%s&by=%s",keyword,by.toString().toLowerCase());
	baseUrl += String.format("&prepage=%s", prePage);
	
	// 基本的搜索語句
	QueryBuilder<Article, Integer> builder = articleDao
		.queryBuilder()
		.orderBy(Article.FIELD_PUBTIME, false)
		.limit((long) prePage)// 查询数量限制
		.offset((long) prePage * (pageNo-1))// 分页
		;
	
	// 计算根据关键字查找到的数目
	long searchCount;
	
	// 搜索关键词
	if (keyword != null && keyword.trim().length() > 0)
	{
		builder.where().like(by.getColumnName(), "%" + keyword + "%");
		searchCount = articleDao.queryBuilder().where().like(by.getColumnName(), "%" + keyword + "%").countOf();
	}else
		searchCount = articleDao.countOf();
	
	// 页面的数量
	long pageCount = 1 + searchCount / prePage;

	//System.out.printf("keyword is '%s' after '%s'\n", keyword, URLDecoder.decode(keyword,"utf-8"));
	
	List<Article> articleList = builder.query();
	pageContext.setAttribute("articleList",articleList);
%>
	<table class="table table-striped table-hover">
		<thead>
		  <tr>
			<th>#</th>
			<th>标题</th>
			<th>作者</th>
			<th>发表时间</th>
			<th>操作</th>
		  </tr>
		</thead>
		<tbody>
		<c:forEach items="${articleList}" var="article">
		  <tr>
			<td><c:out value="${article.getId()}"/></td>
			<td><a href="showarticle.jsp?id=<c:out value="${article.getId()}"/>"><c:out value="${article.getTitle()}"/></a></td>
			<td>
			<a href="?by=author&keyword=<c:out value="${article.getAuthor()}"/>"><c:out value="${article.getAuthor()}"/></a>
			</td>
			<td><fmt:formatDate pattern="yyyy/MM/dd hh:mm" value="${article.getPubtime()}" /></td>
			<td>
				<div class="btn-group">
					<c:if test="${u5.haveRightsOnArticle(article)}">
						<a class="btn btn-primary btn-xs" 
						href="edit_article.jsp?id=<c:out value="${article.getId()}"/>">
						<i class="fa fa-edit"></i> 编辑</a>
						<a class="btn btn-danger btn-xs" 
						href="del_article.jsp?id=<c:out value="${article.getId()}"/>">
						<i class="fa fa-trash-o"></i> 删除</a>
					</c:if>
				</div>
			</td>
		  </tr>
		</c:forEach>
		</tbody>
	</table>
	<!-- /显示文章列表 -->
	
	<!-- 显示分页 -->
	<ul class="list-group">
	<li class="list-group-item text-center">
			<% if(pageCount > 1){ %>
			<ul class="pagination">
			  <li class="<%=pageNo == 1?"disabled":"" %>"><a href="<%=String.format("%s&pageno=%d",baseUrl, 1)%>">&laquo;</a></li>
			  
			  <%
			  	// 实现分页
			  	long minPageNo = 1;
			  	long maxPageNo = pageCount;
			  	int showPageCount = 11;
			  	// 计算页面最小和最大
			  	minPageNo = pageNo - (showPageCount - 1)/2;
			  	maxPageNo = pageNo + (showPageCount - 1)/2;
			  	if(minPageNo < 1)
			  	{
			  		maxPageNo += 1 - minPageNo;
			  		minPageNo = 1;
			  	}
			  	if(maxPageNo > pageCount)
			  		maxPageNo = pageCount;
			  	 %>
			  	
			  <% if(minPageNo > 1){ %>
			  <li class="disabled"><a href="">...</a></li>
			  <%} %>
			  <%
				// 输出中间部分
			  	for(long p = minPageNo; p <= maxPageNo; p ++)
			  	{
			  %>
			  <li class="<%=pageNo == p?"disabled":"" %>"><a href="<%=String.format("%s&pageno=%d",baseUrl, p) %>"><%=p %></a></li>
			  <%}%>
			  
			  <% if(maxPageNo < pageCount){ %>
			  <li class="disabled"><a href="">...</a></li>
			  <%} %>
			  
			  <li class="<%=pageNo == pageCount?"disabled":"" %>"><a href="<%=String.format("%s&pageno=%d",baseUrl, pageCount)%>">&raquo;</a></li>
			  
			</ul>
			<%} %>
		</li>
		<li class="list-group-item text-center">
		共查找到 <%=searchCount %> 篇博文
		</li>
	</ul>
	<!-- /显示分页 -->
</section>

<%@include file="bottom.jsp"%>


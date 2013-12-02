<%@page import="com.j256.ormlite.stmt.SelectArg"%>
<%@page import="com.j256.ormlite.stmt.Where"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<%@page import="com.j256.ormlite.dao.CloseableIterator"%>
<%@page import="com.j256.ormlite.stmt.QueryBuilder"%>
<%@page import="java.util.*"%>
<%@include file="top.jsp"%>

<section class="page-part">

	<div class="page-header section-header">
		<h1>查询用户</h1>
	</div>

	<form class="form-inline navbar-form  " role="search" method="get"
		action="user_list.jsp">
		<div class="input-group">
			<div class="input-group-btn">
				<button type="button"
					class="btn btn-default dropdown-toggle dropdown-to-select"
					data-toggle="dropdown" data-name="by" 
					data-default-value="<%=U5.nullFor(request.getParameter("by"),"account") %>">
					搜索条目 <span class="keep-content caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a data-value="account" data-default href="#">帐户名</a></li>
					<li><a data-value="realname" href="#">真实姓名</a></li>
					<li><a data-value="qq" href="#">QQ</a></li>
					<li><a data-value="email" href="#">邮箱</a></li>
				</ul>

				<input type="hidden" name="by">
			</div>

			<input type="text" name="keyword" 
				class="form-control"
				value="<%=U5.nullFor(request.getParameter("keyword")) %>"
				placeholder="请输入关键词..."> 
				
				<span class="input-group-btn">
				<button class="btn btn-primary btn-group" type="submit">检索</button>
			</span>
		</div>
	</form>


	<%
		int pageNo = U5.tryParseInt(request.getParameter("pageno"), 1);
		int prePage = U5.tryParseInt(request.getParameter("prepage"), 0);
		// 进行当前页面查询的 参数url 用来翻页的时候使用
		String baseUrl= String.format("?"); 
		prePage = prePage == 0 ? 10 : prePage;
		pageNo = pageNo < 1? 1: pageNo;// 页码不能小于等于0
		
		String keyword = request.getParameter("keyword");
		UserSearchBy by = UserSearchBy.ACCOUNT;

		
		try
		{
			by = UserSearchBy.valueOf(request.getParameter("by")
					.toUpperCase());
		} catch (NullPointerException ex){}
		catch(IllegalArgumentException ex){}// enum 可能找不到

		// 添加关键词到 url上
		if(keyword != null)
			baseUrl += String.format("keyword=%s&by=%s",keyword,by.toString().toLowerCase());
		baseUrl += String.format("&prepage=%s", prePage);
		
		// 基本的搜索語句
		QueryBuilder<User, Integer> builder = userDao.queryBuilder()
				.limit((long) prePage)// 查询数量限制
				.offset((long) prePage * (pageNo-1))// 分页
				.orderBy(User.FIELD_REGTIME, false)
				;
		// 计算根据关键字查找到的数目
		long searchCount;
		
		// 搜索关键词
		if (keyword != null && keyword.trim().length() > 0)
		{
			builder.where().like(by.getColumnName(), "%" + keyword + "%");
			searchCount = userDao.queryBuilder().where().like(by.getColumnName(), "%" + keyword + "%").countOf();
		}else
			searchCount = userDao.countOf();
		
		// 页面的数量
		long pageCount = 1 + searchCount / prePage;
		
		
		
		List<User> userList = builder.query();
		pageContext.setAttribute("userList",userList);
		
		// 查询文章数量的语句
		SelectArg articleCountOfUser = new SelectArg();
		Where<Article, Integer> articleCount = articleDao
				.queryBuilder()
				.where()
				.eq(Article.FIELD_AUTHOR, articleCountOfUser)
				;
		
	%>
	<!-- 用户列表 -->

	<ul class="list-group">
		<c:forEach items="${userList}" var="user">
		<% 
			User user = (User)pageContext.getAttribute("user");
			articleCountOfUser.setValue(user.getAccount());
			long userArticleCount = articleCount.countOf();
		%>
		<li class="list-group-item">
			<a href="profile.jsp?id=<c:out value="${user.getId()}"/>">
			<c:out value="${user.getAccount()}"/>
			
			<c:if test="${user.getRealname() != null &&user.getRealname().length() > 0 }">
			<small>(<c:out value="${user.getRealname()}"/>)</small>
			</c:if>
			
			</a>
			
			<c:if test="${user.getEmail() != null && user.getEmail().length() > 0}">
			&lt;<c:out value="${user.getEmail()}"/>&gt;
			</c:if>
			
			<c:if test="${u5.isAdministrator()}">
			<span class="btn-group pull-right">
				<a href="delete_user.jsp?id=<c:out value="${user.getId()}"/>" class="btn btn-danger btn-xs" >
				<i class="fa fa-trash-o"></i> 删除</a>
			</span>
			</c:if>
			
			<br> 
			于 <fmt:formatDate pattern="yyyy/MM/dd hh:mm" value="${user.getRegtime()}" /> 注册,共有博文
			<%=userArticleCount %> 篇.
		</li>
		</c:forEach>
		<!-- /用户列表 -->
		
		<!-- 显示分页 -->
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
			  	
			  	for(long p = minPageNo; p <= maxPageNo; p ++)
			  	{
			  %>
			  <li class="<%=pageNo == p?"disabled":"" %>"><a href="<%=String.format("%s&pageno=%d",baseUrl, p) %>"><%=p %></a></li>
			  <%}%>
			  <li class="<%=pageNo == pageCount?"disabled":"" %>"><a href="<%=String.format("%s&pageno=%d",baseUrl, pageCount)%>">&raquo;</a></li>
			</ul>
			<%} %>
		</li>
		<li class="list-group-item text-center">
		共查找到 <%=searchCount %> 位用户
		</li>
		<!-- /显示分页 -->
	</ul>
	


</section>

<%@include file="bottom.jsp"%>

<%@page import="com.j256.ormlite.stmt.SelectArg"%>
<%@page import="com.j256.ormlite.dao.CloseableIterator"%>
<%@page import="com.j256.ormlite.stmt.QueryBuilder"%>
<%@page import="com.j256.ormlite.stmt.Where"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@include file="top.jsp"%>
<!-- 主内容 -->
<%
	User user = null;
	try
	{
		user = userDao.queryForId(U5.tryParseInt(request.getParameter("id")));
	} catch (SQLException ex)
	{}

	if (user == null)
	try
	{
		Map<String,Object> map = new HashMap<String,Object>();
		map.put(User.FIELD_ACCOUNT, request.getParameter("account"));
		user = userDao.queryForFieldValuesArgs(map).get(0);
	} catch (SQLException ex){} 
	catch (NullPointerException ex){}
	catch (IndexOutOfBoundsException ex){}// 没有结果
	
	
	if (user == null)
	{
		u5.sendError(ErrorMessage.UserNotExists);
	} else
	{
		boolean canEdit = u5.isLogin() && u5.getCurrentUser().getId() == user.getId();
		pageContext.setAttribute("user", user);
		pageContext.setAttribute("canEdit", canEdit);
%>
<section id="profile-page" class="page-part">

	<div class="section-header page-header">
		<h1>用户资料</h1>
	</div>

	<dl class="dl-horizontal">
		<dt>帐号:</dt>
		<dd>
			<c:out value="${user.getAccount()}" />
		</dd>
		<dt>姓名:</dt>
		<dd class="editable" data-type="text" data-name="realname">
			<c:out value="${user.getRealname()}" />
		</dd>
		<dt>QQ:</dt>
		<dd class="editable" data-type="text" data-name="qq">
			<c:out value="${user.getQQ()}" />
		</dd>
		<dt>邮箱:</dt>
		<dd class="editable" data-type="email" data-name="email">
			<c:out value="${user.getEmail()}" />
		</dd>
		<dt>个人主页:</dt>
		<dd class="editable" data-type="url" data-name="homepage">
			<c:out value="${user.getHomePage()}" />
		</dd>
		<dt>注册时间:</dt>
		<dd>
			<c:out value="${u5.formatDate(user.getRegtime())}" />
		</dd>
		<dt>个人说明:</dt>
		<dd class="editable" data-type="textarea" data-name="introduce"><c:out value="${user.getIntroduce()}" /></dd>
	</dl>
	<span data-type="text" class="editable hide" data-name="id"><c:out value="${user.getId()}" /></span>
	
	<div id="msg" class="alert hide alert-danger alert-dismissable">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <strong>错误!</strong> <span id="msg-text">Best check yo self, you're not looking too good.</span>
	</div>
	
<c:if test="${canEdit}">
	<div class="btn-group col-sm-8 col-sm-offset-2">
		<button class="submit-btn btn btn-primary col-sm-12">保存</button>
		<!-- <button class="reset-btn btn btn-default col-sm-5">重置</button> -->
	</div>
</c:if>

</section>

<section id="profile-page" class="page-part">
	<div class="section-header page-header">
		<h1>最新文章</h1>
	</div>

	<ul class="list-group">
	<%
		List<Article> articleList = articleDao.queryBuilder()
			.orderBy(Article.FIELD_PUBTIME, false).limit(10l)
			// 只取10个
			.where().eq(Article.FIELD_AUTHOR, user.getAccount())
			.query();
		pageContext.setAttribute("articleList", articleList);
		long articleCount = u5.articleCountForUserAccount(user.getAccount());
	%>
	<li class="list-group-item">
				<%=user.getAccount() %> 共有 <%=u5.commentCountForUserAccount(user.getAccount()) %> 条回复
				和 <%=articleCount %> 篇文章 
				<% if(articleCount > 10){ %>
				<a href='article_list.jsp?by=author&keyword=<%=user.getAccount() %>'>查看更多</a>
				<%} %>
	</li>
	
	<%
		SelectArg articleIdArg = new SelectArg();
		Where<Comment,Integer> commentForArticle =  commentDao
				.queryBuilder()
				.where()
				.eq(Comment.FIELD_ARTICLE_ID, articleIdArg)
		;
	%>
	<c:forEach items="${articleList}" var="article">
	<% Article article = (Article) pageContext.getAttribute("article"); %>
		<li class="list-group-item">
			<span class="badge">
				<c:out value="${u5.commentCountForArticleId(article.getId())}" />
			</span>
			<a href="showarticle.jsp?id=<%=article.getId()%>"><%=article.getTitle()%></a>
			<br> 
			<a href="profile.jsp?account=<%=article.getAuthor() %>"><%=article.getAuthor() %></a>
			<small>于 <%=U5.formatDate(article.getPubtime())%> 发表</small>
		</li>
	</c:forEach>
	</ul>
</section>

<% if(canEdit){%>
<script src="scripts/profile.js"></script>
<% }%>
<!-- /主内容 -->
<%@include file="bottom.jsp"%>
<%
	}
%>
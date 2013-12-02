<%@page import="com.j256.ormlite.dao.CloseableIterator"%>
<%@page import="com.j256.ormlite.stmt.QueryBuilder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="top.jsp"%>
<!-- 错误消息的提示 -->
<%
	ErrorMessage msg = null;
	try{
		msg = ErrorMessage.valueOf(request.getParameter("msg"));
	}catch(NullPointerException ex){}// by 可能不存在
	catch(IllegalArgumentException ex){}// enum 可能找不到
%>
<div id="error-msg-modal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">错误</h4>
      </div>
      <div class="modal-body">
        <p><%=msg == null?"":msg.getDescription() %></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%if(msg != null){ %>
<script>
$(function(){$('#error-msg-modal').modal();});
</script>
<%} %>
<!-- 错误消息的提示 -->

<!-- 主内容 -->

<section class="page-part">

	<div class="section-header page-header">
		<h1>文章列表</h1>
	</div>

	<!-- 最新文章列表 -->
	<ul class="list-group">
		<%
			 CloseableIterator<Article> itor = articleDao
				.queryBuilder()
				.orderBy(Article.FIELD_PUBTIME, false)
				.limit(10l)// 只取10个
				.iterator();
			// ResultSet rs = stm
			//		.executeQuery("select top 10 id,title,author,pubtime from article order by pubtime desc");
			
			// 显示文章列表
			
			for (int i = 0; i < 10 && itor.hasNext(); i ++) 
			{
				Article article = itor.next();
				long commentCount = commentDao.queryBuilder()
					.where()
					.eq(Comment.FIELD_ARTICLE_ID, article.getId())
					.countOf();
				
				%>
				<li class="list-group-item">
					<span class="badge"><%=commentCount %></span> 
					<a href="showarticle.jsp?id=<%=article.getId() %>"><%=article.getTitle()%></a>
					<br> 
					<a href="profile.jsp?account=<%=article.getAuthor() %>"><%=article.getAuthor() %></a>
					<small>于 <%=U5.formatDate(article.getPubtime())%> 发表</small>
				</li>
				<%
			}
			
			// 显示文章总数，如果还有更多，则显示 查看更多链接
			//ResultSet rs = stm.executeQuery("select count(id) from article");
			long articleCount = articleDao.countOf();
			%>
			<li class="list-group-item">
				博客共计 <%=articleCount %> 篇文章 <%=articleCount > 10?"<a href='article_list.jsp'>查看更多</a>":"" %>
			</li>
			
	</ul>
	<!-- /最新文章列表 -->

</section>


<!-- /主内容 -->
<%@include file="bottom.jsp"%>
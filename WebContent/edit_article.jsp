<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>

<%@include file="top.jsp"%>
<%
	Article article = null;
	try{
		article = articleDao.queryForId(U5.tryParseInt(request.getParameter("id")));
	}catch(SQLException ex){}
	
	pageContext.setAttribute("article",article);
	System.out.printf("article is %s, id is %d ",article,U5.tryParseInt(request.getParameter("id")));
%>
<section class="page-part">

	<div class="page-header section-header">
		<h1><c:out value='${article == null?"添加文章": "编辑文章"}' /></h1>
	</div>

	<form class="form-horizontal" role="form" method="post"
		action="deal_edit_article.jsp?id=<c:out value='${article == null?"": article.getId()}' />">
		<div class="form-group">
			<label for="txt_title" class="col-sm-2 control-label">文章标题</label>
			<div class="col-sm-10">
				<input type="text" required="required" class="form-control"
					value="<c:out value='${article == null?"": article.getTitle()}' />"
					name="txt_title" id="txt_title" placeholder="请输入文章标题">
			</div>
		</div>

		<div class="form-group">
			<label for="content" class="col-sm-2 control-label">文章内容</label>
			<div class="col-sm-10">
				<textarea class="form-control" required="required" rows="15" id="content" name="content"
					placeholder="请输入文章内容"><c:out value='${article == null?"": article.getContent()}' /></textarea>
			</div>
		</div>
		<div class="row">
			<button type="submit" class="btn btn-primary col-sm-3 col-sm-offset-2">提交</button>
			<button type="reset" class="btn btn-warning col-sm-3 col-sm-offset-2">从写</button>
		</div>
	</form>
</section>

<%@include file="bottom.jsp"%>


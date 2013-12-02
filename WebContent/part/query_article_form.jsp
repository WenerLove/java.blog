<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form class="form-inline navbar-form " role="search" action="article_list.jsp">
		<div class="input-group">
			<div class="input-group-btn">
				<button type="button" class="btn btn-default dropdown-toggle dropdown-to-select"
					data-toggle="dropdown" data-name="by" 
					data-default-value="<%=request.getParameter("by") == null?"title":request.getParameter("by") %>" >
					主题 <span class="keep-content caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a data-value="author" href="#">作者</a></li>
					<li><a data-value="title" href="#">标题</a></li>
					<li><a data-value="content" href="#">内容</a></li>
				</ul>

				<input type="hidden" name="by">
			</div>

			<input type="text" name="keyword" class="form-control"
				value="<%=request.getParameter("keyword") == null?"":request.getParameter("keyword") %>"
				placeholder="请输入关键词..."> 
			<span class="input-group-btn">
               <button class="btn btn-primary btn-group" type="submit"><i class="glyphicon glyphicon-search"></i></button>
			</span>
		</div>
	</form>
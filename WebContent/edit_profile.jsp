<%@ page language="java" contentType="text/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/conn.jsp"%>

<% 
	boolean suc = false;
	String error = "";
	User user = null;
	
	if(!u5.isLogin())
		error = "尚未登录,请先登录再进行操作";
	
	user = u5.getCurrentUser();
	int id = U5.tryParseInt(request.getParameter("id"), -1);
	if(error.length() == 0 && user.getId() != id)
		error = "没有权限进行该操作.";
	
	if(error.length() == 0)
	{
		user.setEmail(u5.nullParamFor("email", user.getEmail()));
		user.setRealname(u5.nullParamFor("realname", user.getRealname()));
		user.setIntroduce(u5.nullParamFor("introduce", user.getIntroduce()));
		user.setHomePage(u5.nullParamFor("homepage", user.getHomePage()));
		user.setQQ(u5.nullParamFor("qq", user.getQQ()));
		
		try{
			userDao.update(user);
		}catch(SQLException ex)
		{
			error="更新失败,请稍后再试.";
		}
	}
%>

{
	"suc": <%=error.length() == 0 %>,"error":"<%=error %>"
}
<%@tag description="Overall Page template" pageEncoding="UTF-8"%>
<%@attribute name="header" fragment="true"%>
<%@attribute name="footer" fragment="true"%>
<%@attribute name="styles" fragment="true"%>
<%@attribute name="scripts" fragment="true"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="utf-8" >
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="product" content="Infomation me">
    <meta name="description" content="Infomation you, Interest you, Find you">
    <meta name="author" content="wener(wenermail_AT_gmail.com)">
    
    <t:BasicStyles/>
    <jsp:invoke fragment="styles" />
	<jsp:invoke fragment="header" />
</head>
<body class="container">
	<jsp:doBody />
</body>
<footer>
	<t:BasicAssets/>
	<jsp:invoke fragment="scripts" />
	<jsp:invoke fragment="footer" />
</footer>
</html>
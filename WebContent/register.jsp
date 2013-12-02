<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="CSS/style.css" rel="stylesheet">
<title>用户注册</title>
</head>
<script language="javascript">
	function check() {
		if (myform.txt_regname.value == "") {
			alert("用户名不能为空");
			myform.txt_regname.focus();
			return false;
		}
		if (myform.txt_regrealname.value == "") {
			alert("真实姓名不能为空");
			myform.txt_regrealname.focus();
			return false;
		}
		if (myform.txt_regpwd.value == "") {
			alert("密码不能为空");
			myform.txt_regpwd.focus();
			return false;
		}
		if (myform.txt_regpwd2.value == "") {
			alert("确认不能为空");
			myform.txt_regpwd2.focus();
			return false;
		}
		if (myform.txt_regpwd.value != myform.txt_regpwd2.value) {
			alert("两次密码不一致");
			myform.txt_regpwd.focus();
			return false;
		}
		if (myform.txt_regemail.value == "") {
			alert("邮箱不能为空");
			myform.txt_regemail.focus();
			return false;
		} else {
			for (i = 0; i < myform.txt_regemail.value.length; i++)
				if (myform.txt_regemail.value.charAt(i) == '@')
					break;
			if (i == myform.txt_regemail.value.length) {
				alert("邮箱格式非法");
				myform.txt_regemail.focus();
				return false;
			}
		}
		if (myform.txt_regqq.value != "") {
			for (i = 0; i < myform.txt_regqq.value.length; i++)
				//一旦找到非数字字符就退出
				if (!(myform.txt_regqq.value.charAt(i) >= '0' && myform.txt_regqq.value
						.charAt(i) <= '9'))
					break;
			if (i < myform.txt_regqq.value.length) {
				alert("非法QQ号码！");
				myform.txt_regqq.focus();
				return false;
			}
		}

	}
</script>
<body
	style="MARGIN-TOP: 0px; VERTICAL-ALIGN: top; PADDING-TOP: 0px; TEXT-ALIGN: center">
	<%@include file="top.jsp"%>
	<TABLE width="757" cellPadding=0 cellSpacing=0 style="WIDTH: 755px">
		<TBODY>
			<TR>
				<TD colSpan=3 valign="baseline"
					style="BACKGROUND-IMAGE: url(images/bg.jpg); VERTICAL-ALIGN: middle; HEIGHT: 450px; TEXT-ALIGN: center"><br>
					<form name="myform" action="deal_register.jsp" method="post"
						>
						<table width="85%" border="1" align=center cellpadding=3
							cellspacing=2 bordercolor="#FFFFFF" bgcolor="#FFFFFF"
							class=i_table>
							<tr align="left" bgcolor="#CEEB6B">
								<td height=22 colspan=2 class=right_head><SPAN
									style="FONT-SIZE: 9pt; COLOR: #cc0033"><img
										src="images/fig_02.gif" width="22" height="16"></SPAN> <span
									class="tableBorder_LTR">必填内容</span></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td width=22% align="right" valign=middle class='f_one'>
									用户名</td>
								<td width=78% align="left" class='f_one'><input
									name='txt_regname' type=text id="txt_regname" value='' size=20
									maxlength=14> 长度为3-20位<font color=red>*</font></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" valign=middle>真实姓名</td>
								<td align="left"><input name=txt_regrealname type=text
									id="txt_regrealname" size=20 maxlength=75> <font
									color=red>*</font></td>
							</tr>
							<tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" valign=middle>密码</td>
								<td align="left"><input name=txt_regpwd type=password
									id="txt_regpwd" size=20 maxlength=75> 英文字母或数字等不少于6位<font
									color=red>*</font></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" valign=middle>确认密码</td>
								<td align="left"><input name='txt_regpwd2' type=password
									id="txt_regpwd2" size=20 maxlength=75
									onBlur="if(this.value!=this.form.txt_regpwd.value) alert('您两次输入的密码不一致！');myform.txt_regpwd.focus();">
									<font color=red>*</font></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" valign=middle>Email</td>
								<td align="left"><input name=txt_regemail type=text
									id="txt_regemail" value='' size=35 maxlength=75> <font
									color='#000000'>公开邮箱 <font color=red>*</font></font></td>
							</tr>

							<tr align="left" bgcolor="#CEEB6B">
								<td height=22 colspan=2 class=right_head><img
									src="images/fig_02.gif" width="22" height="16"> <span
									class="tableBorder_LTR">选填内容</span></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" class='f_one'>性别</td>
								<td align="left" class='f_one'><select name="txt_regsex"
									id="txt_regsex">
										<OPTION value=1>男</OPTION>
										<OPTION value=2>女</OPTION>
										<OPTION value=0 selected>保密</OPTION>
								</select></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" class='f_one'>生日</td>
								<td align="left" class='f_one'><input
									name='txt_regbirthday' type=text id="txt_regbirthday" value=''
									size=20 maxlength=14></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" class='f_one'>QQ</td>
								<td align="left" class='f_one'><input name='txt_regqq'
									type=text id='txt_regqq' value='' size=20 maxlength=14></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" class='f_one'>个人主页</td>
								<td align="left" class='f_one'><input
									name='txt_reghomepage' type=text id="txt_reghomepage" value=''
									size=40 maxlength=75></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" valign=middle class='f_one'>个性化签名</td>
								<td align="left" class='f_one'><textarea name='txt_regsign'
										cols=50 rows='4' id="txt_regsign"></textarea></td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td align="right" class='f_one'>自我简介</td>
								<td align="left" class='f_one'><textarea
										name=txt_regintroduce cols=50 rows=4 id="txt_regintroduce"></textarea></td>
							</tr>
						</table>
						<br> <input type='submit' name='regsubmit' value='提 交'>
						&nbsp; <input name="Submit2" type="reset" value="重 填">
					</form></TD>
			</TR>
		</TBODY>
	</TABLE>
	<%@include file="bottom.jsp"%>
</body>
</html>

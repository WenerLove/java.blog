package blog;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 必须要有用户登录才能访问的 Servlet 
 */
public abstract class RequireLoginServlet extends HttpServlet implements Filter 
{
	private static final long serialVersionUID = 1L;

	User currentUser;
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) throws IOException, ServletException
	{
		currentUser = (User)((HttpServletRequest)request).getSession().getAttribute("CurrentUser");
		if (currentUser == null)
		{
			
		}else {
			filterChain.doFilter(request, response);
		}
	}




}

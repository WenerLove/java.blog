package blog;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Servlet implementation class FirstServlet
 */
@WebServlet("/First")
public class FirstServlet extends HttpServlet implements Filter
{

	private static final long serialVersionUID = 1L;

	HttpServletRequest request;
	HttpServletResponse response;
	HttpSession session;
	PrintWriter out;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FirstServlet()
	{
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException
	{
		// TODO Auto-generated method stub
	}
	@Override
	public void service(ServletRequest arg0, ServletResponse arg1)
			throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		super.service(arg0, arg1);
		renewObject(arg0, arg1);
		out.print("do my service");
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest arg0,
			HttpServletResponse arg1) throws ServletException, IOException
	{
		renewObject(arg0, arg1);
		out.print("In First Servlet. Can not see this.");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain filterChain) throws IOException, ServletException
	{
		
		renewObject(arg0, arg1);
		out.print("do filter");
		if (request.getParameter("name").equals("wener"))
		{
			filterChain.doFilter(arg0, arg1);
		}
		System.out.println("do filter");
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException
	{
		// TODO Auto-generated method stub
		
	}

	private void renewObject(ServletRequest arg0, ServletResponse arg1) throws IOException
	{
		request = (HttpServletRequest) arg0;
		response = (HttpServletResponse) arg1;
		out = response.getWriter();
		session = request.getSession();
	}

}

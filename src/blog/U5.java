package blog;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.taglibs.standard.lang.jstl.test.StaticFunctionTests;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.jdbc.JdbcConnectionSource;
import com.j256.ormlite.support.ConnectionSource;
import com.j256.ormlite.table.TableUtils;

import java.net.URLDecoder;

/**
 * 辅助函数
 */
public class U5 {
	public final static String DEFAULT_DATE_FORMAT = "yyyy-MM-dd hh:mm";
	private final static String DATABASE_URL = "jdbc:h2:tcp://localhost/~/test";
	private final static String DATABASE_USER = "";
	private final static String DATABASE_PASSWORD = "";

	private static Dao<Article, Integer> articleDao;
	private static Dao<User, Integer> userDao;
	private static Dao<Comment, Integer> commentDao;
	private static ConnectionSource connectionSource = null;

	HttpSession session;
	Connection connection = null;
	HttpServletRequest request;
	HttpServletResponse response;
	PrintWriter out;
	ServletContext application;

	public U5(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		this.session = session;
		this.request = request;
		this.response = response;
		this.application = session.getServletContext();

		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		connectionSource = getConnectionSource();
		
		InitDatabase();
	}

	public ConnectionSource getConnectionSource()
	{
		if (connectionSource == null)
			connectionSource = (ConnectionSource) application
					.getAttribute("connectionSource");
		
		if (connectionSource == null)
		{
			try
			{
				connectionSource = new JdbcConnectionSource(DATABASE_URL, DATABASE_USER, DATABASE_PASSWORD);
			} catch (SQLException e)
			{
				System.out.println("getConnectionSource FAILED.");
				e.printStackTrace();
			}
		}
		
		application.setAttribute("connectionSource", connectionSource);
		
		return connectionSource;
	}

	public void InitDatabase() {
		
		try {
			TableUtils.createTableIfNotExists(connectionSource, Article.class);
			TableUtils.createTableIfNotExists(connectionSource, Comment.class);
			TableUtils.createTableIfNotExists(connectionSource, User.class);
		} catch (SQLException e) {
			// 这里不会因为 table 存在抛出错误
			return;
		}
		
		// create our data-source for the database
		try {
			
			articleDao = DaoManager.createDao(connectionSource, Article.class);
			commentDao = DaoManager.createDao(connectionSource, Comment.class);
			userDao = DaoManager.createDao(connectionSource, User.class);
			
			if (userDao.countOf() > 0 || articleDao.countOf() > 0)
			{
				return;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}


		// 添加一个默认用户
		User user = new User();
		user.setAccount("admin");
		user.setPassword("admin");
		user.setIp(request.getRemoteAddr());
		user.setLevel(AccountLevel.Administrator);
		
		try {
			userDao.create(user);
		} catch (SQLException e) {
			System.out.println("添加默认用户失败。\n:" + e.getMessage());
		}

		// 添加一个默认文章
		Article article = new Article();
		article.setTitle("欢迎使用博客园");
		article.setContent("这是博客的第一篇文章哦！");
		article.setAuthor(user.getAccount());
		try {
			articleDao.create(article);
		} catch (SQLException e) {
			System.out.println("添加默认文章失败。\n:" + e.getMessage());
		}
	}

	public Connection getConnection() {
		if (connection != null)
			return connection;

		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			// conn = DriverManager.getConnection("jdbc:odbc:blog", "", "");
			String connectionQuery =
			// "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=data/blog.mdb;uid=; pwd=;";
			"jdbc:odbc:blog";
			connection = DriverManager.getConnection(connectionQuery, "", "");
		} catch (Exception e) {
			out.print("数据库连接失败:" + e.getMessage());
			e.printStackTrace();
		}

		return connection;
	}

	public Statement getStatement() {
		try {
			return getConnection().createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public User Login(String account, String password) {
		User user = null;
		try {
			user = userDao.queryBuilder().where()
					.eq(User.FIELD_ACCOUNT, account).and()
					.eq(User.FIELD_PASSWORD, password).queryForFirst();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (user != null)
			session.setAttribute("CurrentUser", user);

		return user;
	}

	public boolean isLogin() {
		return session.getAttribute("CurrentUser") != null;
	}

	public boolean isAdministrator() {
		User user = getCurrentUser();
		return user != null && user.getLevel() == AccountLevel.Administrator;
	}

	public boolean requireLogin() {
		if (!isLogin()) {
			sendError(ErrorMessage.RequireLogin);
			return false;
		}
		return true;
	}

	public boolean requireAdmin() {
		if (!isAdministrator()) {
			sendError(ErrorMessage.RequireAdmin);
			return false;
		}
		return true;
	}

	public void sendError(ErrorMessage msg) {
		try {
			response.sendRedirect("error.jsp?msg=" + msg.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public User getCurrentUser() {
		return (User) session.getAttribute("CurrentUser");
	}

	public Dao<Article, Integer> getArticleDao() {
		return articleDao;
	}

	public Dao<Comment, Integer> getCommentDao() {
		return commentDao;
	}

	public Dao<User, Integer> getUserDao() {
		return userDao;
	}

	public User getArticleAuthor(Article article) {
		User user = null;

		if (article != null && article.getAuthor() != null)
			try {
				user = userDao.queryBuilder().where()
						.eq(User.FIELD_ACCOUNT, article.getAuthor())
						.queryForFirst();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		return user;
	}

	public void GoBack() {
		String url = request.getHeader("Referer");
		if (url == null || url.length() == 0)
			url = "index.jsp";
		try {
			response.sendRedirect(url);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void ClearDatabase() {
		try {
			TableUtils.dropTable(connectionSource, Comment.class, true);
			TableUtils.dropTable(connectionSource, Article.class, true);
			TableUtils.dropTable(connectionSource, User.class, true);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void Logout() {
		session.removeAttribute("CurrentUser");
		session.invalidate();
	}

	/**
	 * 检测账户是否存在
	 * 
	 * @param account
	 * @return true 存在
	 */
	public boolean isAccountExists(String account) {
		try {
			return userDao.queryBuilder().where()
					.eq(User.FIELD_ACCOUNT, account).queryForFirst() != null;
		} catch (SQLException e) {
			return false;
		}
	}

	public static Integer tryParseInt(String text, Integer whenNull) {
		try {
			return new Integer(text);
		} catch (NumberFormatException e) {
			return whenNull;
		}
	}
	public static Integer tryParseInt(String text) {
		return tryParseInt(text, null);
	}
	public static String nullFor(String str, String whenNull)
	{
		return str == null?whenNull: str;
	}
	public static String nullFor(String str)
	{
		return nullFor(str,"");
	}

	public boolean haveRightsOnArticle(Article article)
	{
		User user = getCurrentUser();
		return isAdministrator() || (user != null && article.getAuthor() == user.getAccount());
	}
	
	public static String formatDate(Date date, String pattern)
	{
		return new SimpleDateFormat(pattern).format(date);
	}
	public static String formatDate(Date date)
	{
		return formatDate(date, DEFAULT_DATE_FORMAT);
	}
	public long articleCountForUserAccount(String account) throws SQLException
	{
		return articleDao.queryBuilder()
					.where()
					.eq(Article.FIELD_AUTHOR, account)
					.countOf();
	}
	public long commentCountForUserAccount(String account) throws SQLException
	{
		return commentDao.queryBuilder()
					.where()
					.eq(Comment.FIELD_USER_ACCOUNT, account)
					.countOf();
	}
	public long commentCountForArticleId(String id) throws SQLException
	{
		return commentDao.queryBuilder()
					.where()
					.eq(Comment.FIELD_ARTICLE_ID, id)
					.countOf();
	}
	public User getCommentUser(Comment comment) throws SQLException
	{
		return userDao.queryBuilder()
				.where()
				.eq(User.FIELD_ACCOUNT, comment.getUserAccount())
				.queryForFirst();
	}

	/**
	 * 判断是否设置了该参数
	 * @param paramName
	 */
	public boolean isset(String paramName)
	{
		return request.getParameter(paramName) != null;
	}
	/**
	 * 如果该参数为 null 则
	 * @param paramName 参数名 即 request.getParameter
	 * @return
	 */
	public String nullParamFor(String paramName, String whenNull)
	{
		return nullFor(request.getParameter(paramName),whenNull);
	}
}

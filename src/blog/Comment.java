package blog;

import java.util.Date;

import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "comment")
public class Comment {
	public final static String FIELD_ID = "id";
	public final static String FIELD_ARTICLE_ID = "article_id";
	public final static String FIELD_USER_ACCOUNT = "user_account";
	public final static String FIELD_CONTENT = "content";
	public final static String FIELD_PUBTIME = "pubtime";
	
	@DatabaseField(columnName=FIELD_ID, generatedId=true, readOnly=true, dataType = DataType.INTEGER)
	private int id;
	
	@DatabaseField(columnName=FIELD_ARTICLE_ID)
	private int articleId;
	
	@DatabaseField(columnName=FIELD_USER_ACCOUNT)
	private String userAccount;
	
	@DatabaseField(columnName=FIELD_CONTENT)
	private String content;
	@DatabaseField(columnName=FIELD_PUBTIME,dataType=DataType.DATE_LONG)
	private Date pubtime;
	
	public Comment()
	{
		pubtime = new Date();
	}
	
	public int getArticleId()
	{
		return articleId;
	}

	public void setArticleId(int articleId)
	{
		this.articleId = articleId;
	}

	public String getUserAccount()
	{
		return userAccount;
	}

	public void setUserAccount(String userAccount)
	{
		this.userAccount = userAccount;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public Date getPubtime()
	{
		return pubtime;
	}

	public void setPubtime(Date pubtime)
	{
		this.pubtime = pubtime;
	}

	public int getId()
	{
		return id;
	}


}

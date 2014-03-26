package me.wener.practice.blog;

import java.util.Date;

import lombok.Getter;

import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "comment")
public class Comment
{
	public final static String FIELD_ID = "id";
	public final static String FIELD_ARTICLE_ID = "article_id";
	public final static String FIELD_USER_ACCOUNT = "user_account";
	public final static String FIELD_CONTENT = "content";
	public final static String FIELD_PUBTIME = "pubtime";

	@DatabaseField(columnName = FIELD_ID, generatedId = true, readOnly = true)
	@Getter
	private int id;

	@DatabaseField(columnName = FIELD_ARTICLE_ID)
	@Getter
	private int articleId;

	@DatabaseField(columnName = FIELD_USER_ACCOUNT)
	@Getter
	private String userAccount;

	@DatabaseField(columnName = FIELD_CONTENT)
	@Getter
	private String content;
	@DatabaseField(columnName = FIELD_PUBTIME, dataType = DataType.DATE_LONG)
	@Getter
	private Date pubtime;

	public Comment()
	{
		pubtime = new Date();
	}

	public void setArticleId(int articleId)
	{
		this.articleId = articleId;
	}

	public void setUserAccount(String userAccount)
	{
		this.userAccount = userAccount;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public void setPubtime(Date pubtime)
	{
		this.pubtime = pubtime;
	}

}

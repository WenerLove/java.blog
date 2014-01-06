package blog;

import java.util.Date;

import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "article")
public class Article 
{
	public final static String FIELD_ID = "id"; 
	public final static String FIELD_TITLE = "title";
	public final static String FIELD_CONTENT = "content";
	public final static String FIELD_AUTHOR = "author";
	public final static String FIELD_PUBTIME = "pubtime";
	
	@DatabaseField(columnName=FIELD_ID, generatedId = true, readOnly=true, dataType = DataType.INTEGER)
	private int id;

	@DatabaseField(columnName=FIELD_TITLE)
	private String title;
	@DatabaseField(columnName=FIELD_CONTENT, dataType = DataType.LONG_STRING)
	private String content;
	@DatabaseField(columnName=FIELD_AUTHOR)
	private String author;
	@DatabaseField(columnName=FIELD_PUBTIME,dataType=DataType.DATE_LONG)
	private Date pubtime;

	public Article()
	{
		pubtime = new Date();
		
	}
	
	public int getId() {
		return id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public Date getPubtime() {
		return pubtime;
	}

	public void setPubtime(Date pubtime) {
		this.pubtime = pubtime;
	}

}

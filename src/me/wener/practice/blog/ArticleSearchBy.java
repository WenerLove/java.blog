package me.wener.practice.blog;

public enum ArticleSearchBy {
	TITLE(Article.FIELD_TITLE),
	CONTENT(Article.FIELD_CONTENT),
	AUTHOR(Article.FIELD_AUTHOR);
	
	String columnName;
	ArticleSearchBy(String columnName)
	{
		this.columnName = columnName;
	}
	public String getColumnName()
	{
		return columnName;
	}

}

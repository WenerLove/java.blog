package blog;

public enum UserSearchBy
{
	ACCOUNT(User.FIELD_ACCOUNT), 
	REALNAME(User.FIELD_REALNAME), 
	EMAIL(User.FIELD_EMAIL), 
	QQ(User.FIELD_QQ),
	SEX(User.FIELD_SEX)
	;
	
	String columnName;
	UserSearchBy(String columnName)
	{
		this.columnName = columnName;
	}
	public String getColumnName()
	{
		return columnName;
	}

}

package blog;

import java.util.Date;

import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "user")
public class User
{

	public final static String FIELD_ID = "id";
	public final static String FIELD_ACCOUNT = "account";
	public final static String FIELD_PASSWORD = "password";
	public final static String FIELD_REALNAME = "realname";
	public final static String FIELD_BIRTHDAY = "birthday";
	public final static String FIELD_QQ = "qq";
	public final static String FIELD_EMAIL = "email";
	public final static String FIELD_SEX = "sex";
	public final static String FIELD_HOMEPAGE = "homepage";
	public final static String FIELD_INTRODUCE = "introduce";
	public final static String FIELD_SIGN = "sign";
	public final static String FIELD_IP = "ip";
	public final static String FIELD_LEVEL = "level";
	public final static String FIELD_REGTIME = "regtime";
	
	@DatabaseField(columnName = FIELD_ID, generatedId = true, readOnly = true)
	private int id;

	@DatabaseField(columnName = FIELD_ACCOUNT, canBeNull = false, unique = true, uniqueIndex = true)
	private String account;

	@DatabaseField(columnName = FIELD_PASSWORD, canBeNull = false)
	private String password;

	@DatabaseField(columnName = FIELD_QQ, defaultValue = "")
	private String qq;

	@DatabaseField(columnName = FIELD_EMAIL, defaultValue = "")
	private String email;

	@DatabaseField(columnName = FIELD_SEX, defaultValue = "")
	private String sex;

	@DatabaseField(columnName = FIELD_HOMEPAGE, defaultValue = "")
	private String homePage;

	@DatabaseField(columnName = FIELD_INTRODUCE, defaultValue = "")
	private String introduce;

	@DatabaseField(columnName = FIELD_SIGN, defaultValue = "")
	private String sign;

	@DatabaseField(columnName = FIELD_IP, defaultValue = "")
	private String ip;

	@DatabaseField(columnName = FIELD_REALNAME, defaultValue = "")
	private String realname;
	


	@DatabaseField(columnName = FIELD_LEVEL)
	private AccountLevel level;

	@DatabaseField(columnName = FIELD_BIRTHDAY, dataType = DataType.DATE_LONG)
	private Date birthday;
	
	@DatabaseField(columnName = FIELD_REGTIME, dataType = DataType.DATE_LONG)
	private Date regtime;
	
	
	public User()
	{
		//birthday = new Date();
		regtime = new Date();
		level = AccountLevel.Normal;
	}

	public String getAccount()
	{
		return account;
	}

	public void setAccount(String account)
	{
		this.account = account;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getQQ()
	{
		return qq;
	}

	public void setQQ(String qq)
	{
		this.qq = qq;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getSex()
	{
		return sex;
	}

	public void setSex(String sex)
	{
		this.sex = sex;
	}

	public String getHomePage()
	{
		return homePage;
	}

	public void setHomePage(String homePage)
	{
		this.homePage = homePage;
	}

	public String getIntroduce()
	{
		return introduce;
	}

	public void setIntroduce(String introduce)
	{
		this.introduce = introduce;
	}

	public String getSign()
	{
		return sign;
	}

	public void setSign(String sign)
	{
		this.sign = sign;
	}

	public String getIp()
	{
		return ip;
	}

	public void setIp(String ip)
	{
		this.ip = ip;
	}

	public AccountLevel getLevel()
	{
		return level;
	}

	public void setLevel(AccountLevel fig)
	{
		this.level = fig;
	}

	public Date getBirthday()
	{
		return birthday;
	}

	public void setBirthday(Date birthday)
	{
		this.birthday = birthday;
	}

	public int getId()
	{
		return id;
	}

	public int setId(int id)
	{
		return this.id = id;
	}

	public Date getRegtime()
	{
		return regtime;
	}

	public void setRegtime(Date regtime)
	{
		this.regtime = regtime;
	}
	public String getRealname()
	{
		return realname;
	}

	public void setRealname(String realname)
	{
		this.realname = realname;
	}
}

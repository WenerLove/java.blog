package me.wener.practice.blog;

import java.util.Date;

import lombok.Getter;
import lombok.ToString;
import lombok.experimental.Builder;

import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "user")

@ToString
public class User
{

	public final static String FIELD_ID = "id";
	public final static String FIELD_ACCOUNT = "account";
	public final static String FIELD_PASSWORD = "password";
	public final static String FIELD_REALNAME = "realname";
	public final static String FIELD_BIRTHDAY = "birthday";
	public final static String FIELD_QQ = "qq";
	public final static String FIELD_EMAIL = "email";
	public final static String FIELD_GENDER = "gender";
	public final static String FIELD_HOMEPAGE = "homepage";
	public final static String FIELD_INTRODUCE = "introduce";
	public final static String FIELD_SIGN = "sign";
	public final static String FIELD_IP = "last_signin_ip";
	public final static String FIELD_LEVEL = "account_level";
	public final static String FIELD_REGTIME = "regiter_date";

	@DatabaseField(columnName = FIELD_ID, generatedId = true, readOnly = true)
	@Getter
	private int id;

	@DatabaseField(columnName = FIELD_ACCOUNT, canBeNull = false,
			unique = true, uniqueIndex = true)
	@Getter
	private String account;

	@DatabaseField(columnName = FIELD_PASSWORD, canBeNull = false)
	@Getter
	private String password;

	@DatabaseField(columnName = FIELD_QQ, defaultValue = "")
	@Getter
	private String qq;

	@DatabaseField(columnName = FIELD_EMAIL, defaultValue = "")
	@Getter
	private String email;

	@DatabaseField(columnName = FIELD_GENDER, defaultValue = "")
	@Getter
	private String sex;

	@DatabaseField(columnName = FIELD_HOMEPAGE, defaultValue = "")
	@Getter
	private String homePage;

	@DatabaseField(columnName = FIELD_INTRODUCE, defaultValue = "")
	@Getter
	private String introduce;

	@DatabaseField(columnName = FIELD_SIGN, defaultValue = "")
	@Getter
	private String sign;

	@DatabaseField(columnName = FIELD_IP, defaultValue = "")
	@Getter
	private String lastSigninIP;

	@DatabaseField(columnName = FIELD_REALNAME, defaultValue = "")
	@Getter
	private String realname;

	@DatabaseField(columnName = FIELD_LEVEL)
	@Getter
	private AccountLevel level;

	@DatabaseField(columnName = FIELD_BIRTHDAY, dataType = DataType.DATE_LONG)
	private Date birthday;

	@DatabaseField(columnName = FIELD_REGTIME, dataType = DataType.DATE_LONG)
	private Date registerDate;

	public User()
	{
	}
	
	public void setAccount(String account)
	{
		this.account = account;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public void setQQ(String qq)
	{
		this.qq = qq;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public void setSex(String sex)
	{
		this.sex = sex;
	}

	public void setHomePage(String homePage)
	{
		this.homePage = homePage;
	}

	public void setIntroduce(String introduce)
	{
		this.introduce = introduce;
	}

	public void setSign(String sign)
	{
		this.sign = sign;
	}

	public void setIp(String ip)
	{
		lastSigninIP = ip;
	}

	public void setLevel(AccountLevel fig)
	{
		this.level = fig;
	}

	public void setBirthday(Date birthday)
	{
		this.birthday = birthday;
	}

	public int setId(int id)
	{
		return this.id = id;
	}

	public void setRegtime(Date regtime)
	{
		this.registerDate = regtime;
	}

	public void setRealname(String realname)
	{
		this.realname = realname;
	}
}

package blog;

public enum ErrorMessage
{
	RequireLogin("请先登录再进行操作."),
	RequireAdmin("该操作需要管理员权限."),
	LoginFailed("登录失败,请检查你的帐号或密码是否正确."),
	EditArticleFailed("编辑文章失败,请稍候再试."),
	RegisterFailed("注册失败,请稍候再试."),
	AccountAlreadyExists("注册的账号已经存在."),
	PasswordIncorrect("密码错误."),
	ArticleNotExists("该文章不存在."),
	UserNotExists("该用户不存在."),
	NoCommentContent("无评论内容."),
	UnknowError("未知错误,请稍后再试.")
	;
	
	String title;
	String description;
	public String getTitle()
	{
		return title;
	}
	public String getDescription()
	{
		return description;
	}
	ErrorMessage(String description)
	{
		this(null, description);
	}
	ErrorMessage(String title, String description)
	{
		this.title = title;
		this.description = description;
	}
}

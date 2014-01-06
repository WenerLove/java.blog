<!-- title: 我的JSP作业, 简单的博客 -->
<!-- category: Web -->
<!-- tag: java, jsp -->
<!-- date: 2013/12/2 -->
<!-- state: published -->
<!-- link: java.blog -->
﻿
java.blog
=========

我的作业,使用 jsp 实现的简单的博客.

截图
----

![首页截图](https://raw.github.com/WenerLove/java.blog/master/index_screenshot.png)

![登录和注册截图](https://raw.github.com/WenerLove/java.blog/master/login_screenshot.png)

<!-- more -->

关于搭建
-------

数据库使用的 h2,连接 URL 在 U5.java 里,搭建的时候根据需要修改该连接.

当前数据库链接设置为：

```java
private final static String DATABASE_URL = "jdbc:h2:C:/blog";
private final static String DATABASE_USER = "sa";
private final static String DATABASE_PASSWORD = "";
```

 `jdbc:h2:C:/blog` 是嵌入式模式，不需要服务器即可允许。并且数据库保存位置为
 `C:/blog`.
 
修改为 `jdbc:h2:tcp://localhost/~test` 则会使用服务器模式。

博客使用的数据表会自动创建，所以不需要进行任何手动操作。


使用了
------

* [bootstrap](http://getbootstrap.com/)
* [jquery](http://jquery.com/)
* [ormlite](http://ormlite.com/)
* [h2 database](http://h2database.com)
* [font awesome](http://fontawesome.io/)
* jstl,servlet
* [less](http://lesscss.org/)
* json3
* [x-editable](http://vitalets.github.io/x-editable/)

注意
----

* generate.jsp 是用于生成测试数据的

Change Log
----------

* 2014/1/6 添加了 HeroUnit 和 Footer

TODO
----

* <del>修改数据连接的获取方式,将连接保存到 `application` 上,以支持嵌入式模式,只进行一次连接</del>

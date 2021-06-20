<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>拼优购-综合网购首选-正品低价、品质保障、配送及时、轻松购物!
        </title>
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
        <script src="js/bootstrap.min.js"></script>
        <!--网站说明-->
        <meta name="description" content="拼优购作为新电商开创者，致力于将娱乐社交的元素融入电商运营中，
                    通过“社交+电商”的模式，让更多的用户带着乐趣分享实惠，享受全新的共享式购物体验。"/>
        <!--关键字-->
        <meta name="keywords" content="拼优购 拼优购商城 pinyougou 拼 拼团 团购 团购app 购物 零食 划算 好货 捡漏"/>
        <!--引入图标-->
        <link rel="shortcut icon" href="favicon.ico"/>
        <!--引入初始化样式文件-->
        <link rel="stylesheet" href="css/pdd_init.css">
        <!--引入公共的样式文件-->
        <link rel="stylesheet" href="css/commons.css">

        <!--取消链接下划线-->
        <link rel="stylesheet" href="css/a_a.css">
		<!--导入jquery-->
		<script src="js/jquery-3.2.1.min.js"></script>
    </head>
    <body>
    <!--引入头部-->
    <section class="shortcut">
        <div class="w">
            <div class="f1">
                <ul>
                    <li>
                        <div>
                            <c:if test="${user.username == null }">
                                拼优购欢迎您！
                            </c:if>
                            <c:if test="${user.username != null }">
                                ${user.username},欢迎您！
                            </c:if>

                        </div>&nbsp;&nbsp;
                    </li>
                    <li>
                        <c:if test="${user.username == null }">
                            <a href="login.jsp">请登录</a> &nbsp;
                            <a href="register.jsp" class="style_red">免费注册</a>
                        </c:if>

                    </li>
                    <li>
                        <c:if test="${user.username != null }">
                            <%--                        <a href="center.jsp" class="style_red">个人中心</a>&nbsp;--%>
                            <a href="javascript:location.href='exitServlet';" class="style_red">退出</a>
                        </c:if>

                    </li>
                </ul>
            </div>

            <div class="fr">
                <ul>
                    <li>我的订单</li>
                    <li></li>
                    <li>
                        <div class="dropdown">
                            <button  type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                我的拼优购
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <div>&nbsp;&nbsp;<a href="#">砍一刀</a></div>
                                <div>&nbsp;&nbsp;<a href="#">已买宝贝</a></div>
                                <div>&nbsp;&nbsp;<a href="#">已卖宝贝</a></div>
                            </ul>
                        </div>
                    </li>
                    <li></li>
                    <li>拼优购VIP</li>
                    <li></li>
                    <li>企业采购</li>
                    <li></li>

                    <li>
                        <div class="dropdown">
                            <button  type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                关注优购
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <div>&nbsp;&nbsp;<a href="#">砍一刀</a></div>
                                <div>&nbsp;&nbsp;<a href="#">已买宝贝</a></div>
                                <div>&nbsp;&nbsp;<a href="#">已卖宝贝</a></div>
                            </ul>
                        </div>
                    </li>
                    <li></li>
                    <li>
                        <div class="dropdown">
                            <button  type="button" id="dropdownMenu4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                客服热线
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <div>&nbsp;&nbsp;<a href="#">砍一刀</a></div>
                                <div>&nbsp;&nbsp;<a href="#">已买宝贝</a></div>
                                <div>&nbsp;&nbsp;<a href="#">已卖宝贝</a></div>
                            </ul>
                        </div>
                    </li>
                    <li></li>
                    <li>
                        <div class="dropdown">
                            <button  type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                网站导航
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <div>&nbsp;&nbsp;<a href="#">砍一刀</a></div>
                                <div>&nbsp;&nbsp;<a href="#">已买宝贝</a></div>
                                <div>&nbsp;&nbsp;<a href="#">已卖宝贝</a></div>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <!--头部模块-->
    <header class="header w">
        <!--logo模块-->
        <div class="logo">
            <h1>
                <a href="index.jsp" title="拼优购商城">拼优购商城</a>
            </h1>
        </div>

        <!--搜索模块-->
        <div class="search">
            <input type="search" name=" " id=" " placeholder="拼一下·更实惠">
            <button>搜索</button>
        </div>

        <!--热词模块-->
        <div class="hotwords">
            <a href="#" class="style_red">百亿补贴</a>
            <a href="#">优惠首发</a>
            <a href="#">9.9包邮</a>
            <a href="#">满减活动</a>
            <a href="#">拼团活动</a>
            <a href="#">全场1折</a>
            <a href="#">助力砍一刀</a>
        </div>

        <!--购物车模块-->
        <div class="shopcar">
            我的购物车
            <i class="count">888</i>
        </div>
    </header>
    <div id="header"></div>
        <!-- 头部 end -->
    	<div style="text-align:center;red:yellow;font-weight:bold;height:150px;padding-top:100px;padding-bottom:200px;font-size:30px;">
    		<h4>恭喜，注册成功！请激活账户</h4>
    	</div>
        <!--引入尾部-->
    	<div id="footer"></div>
    <!--底部模块-->
    <iframe src="bottom.jsp" width="100%" height="400" scrolling="no" frameborder="0"></iframe>
    </body>
</html>
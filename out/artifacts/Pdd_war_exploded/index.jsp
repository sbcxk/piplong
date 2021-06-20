<%@ page import="service.impl.ProductServiceImpl" %>
<%@ page import="service.ProductService" %>
<%@ page import="domain.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="32kb" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <!--引入index首页文件-->
    <link rel="stylesheet" href="css/index.css">
    <!--取消链接下划线-->
    <link rel="stylesheet" href="css/a_a.css">
    <script src="js/getParameter.js"></script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/top.js"></script>
    <script src="js/foot.js"></script>
    <script>
        $(function () {
            $("#search_button").click(function () {
                var pname=$("#search_input").val();
                location.href="${pageContext.request.contextPath}/findAllProduct?method=doPost&pid="+pname;
            })
        })


    </script>
</head>
<body>
<%--<jsp:forward page="/indexServlet"></jsp:forward>--%>
<%
    ProductService ps=new ProductServiceImpl();

    List<Product> hotList=ps.findHot();
    List<Product> newList=ps.findNew();

    //将两个list存入request
    request.setAttribute("hList",hotList);
    request.setAttribute("nList",newList);
%>
<!--快捷导航栏模块-->
<div id="shopping_top"></div>



<!--nav模块-->
<nav class="nav">
    <div class="w">
        <div class="dropdowns">
            <div class="dt">全部商品</div>
            <div class="dd">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/categoryPageServlet?method=doPost&cid=1">家用电器</a></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/categoryPageServlet?method=doPost&cid=2">手机</a><a>/</a>
                        <a href="${pageContext.request.contextPath}/categoryPageServlet?method=doPost&cid=2">数码</a><a>/</a>
                        <a href="${pageContext.request.contextPath}/categoryPageServlet?method=doPost&cid=2">配件</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/categoryPageServlet?method=doPost&cid=3">电脑</a><a>/</a>
                        <a href="${pageContext.request.contextPath}/categoryPageServlet?method=doPost&cid=3">办公</a>
                    </li>
                    <li>
                        <a href="#">家居</a><a>/</a>
                        <a href="#">家具</a><a>/</a>
                        <a href="#">家装</a><a>/</a>
                        <a href="#">厨具</a>
                    </li>
                    <li>
                        <a href="#">男装</a><a>/</a>
                        <a href="#">女装</a><a>/</a>
                        <a href="#">童装</a><a>/</a>
                        <a href="#">内衣</a>
                    </li>
                    <li>
                        <a href="#">美妆</a><a>/</a>
                        <a href="#">个人清洁</a><a>/</a>
                        <a href="#">宠物</a>
                    </li>
                    <li>
                        <a href="#">女鞋</a><a>/</a>
                        <a href="#">箱包</a><a>/</a>
                        <a href="#">钟表</a><a>/</a>
                        <a href="#">珠宝</a>
                    </li>
                    <li>
                        <a href="#">男鞋</a><a>/</a>
                        <a href="#">运动</a><a>/</a>
                        <a href="#">户外</a>
                    </li>
                    <li>
                        <a href="#">房产</a><a>/</a>
                        <a href="#">汽车</a><a>/</a>
                        <a href="#">汽车用品</a>
                    </li>
                    <li>
                        <a href="#">母婴</a><a>/</a>
                        <a href="#">玩具乐器</a>
                    </li>
                    <li>
                        <a href="#">食品</a><a>/</a>
                        <a href="#">酒类</a><a>/</a>
                        <a href="#">生鲜</a><a>/</a>
                        <a href="#">特产</a>
                    </li>
                    <li>
                        <a href="#">艺术</a><a>/</a>
                        <a href="#">礼品鲜花</a><a>/</a>
                        <a href="#">农资绿植</a>
                    </li>
                    <li>
                        <a href="#">医药保健 </a><a>/</a>
                        <a href="#">计生情趣</a>
                    </li>
                    <li>
                        <a href="#">图书</a><a>/</a>
                        <a href="#">文娱</a><a>/</a>
                        <a href="#">教育</a><a>/</a>
                        <a href="#">电子书</a>
                    </li>
                </ul>
            </div>
        </div>
        <%@include file="/head.jsp" %>
        <%--<div class="navitems">
            <ul id="head">
                <li><a href="#">服装城</a></li>
                <li><a href="#">电器城</a></li>
                <li><a href="#">生鲜超市</a></li>
                <li><a href="#">医药馆</a></li>
                <li><a href="#">营业厅</a></li>
                <li><a href="#">魅力惠</a></li>
                <li><a href="#">飞猪旅行</a></li>
                <li><a href="#">苏宁易购</a></li>
            </ul>
        </div>--%>
    </div>
</nav>

<!--首页主题模块-->
<div class="w">
    <div class="main">
        <!--轮播图-->
        <div class="focus">
            <ul>
                <li>
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner" role="listbox">
                            <div class="item active">

                                <img src="images/slideshow1.jpg" alt="...">
                                <div class="carousel-caption">
                                    ...
                                </div>
                            </div>
                            <div class="item">
                                <a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=17">
                                    <img src="images/slideshow2.png" alt="...">
                                </a>

                                <div class="carousel-caption">
                                    ...
                                </div>
                            </div>
                            <div class="item">
                                <a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=18">
                                    <img src="images/slideshow3.png" alt="...">
                                </a>

                                <div class="carousel-caption">
                                    ...
                                </div>
                            </div>
                        </div>

                        <!-- Controls -->
                        <a class="left carousel-control" href="#carousel-example-generic" role="button"
                           data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#carousel-example-generic" role="button"
                           data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </li>
            </ul>

        </div>
        <!--快报模块-->
        <div class="newflash">
            <div class="new">
                <div class="new-hd">
                    <h5>优购热搜TOP</h5>
                    <a href="#" class="more">更多</a>
                </div>
                <div class="new-bd">
                    <ul>
                        <%--<li><a href="#"><strong style="color: red">[1]</strong>汪峰官宣怀孕！！！</a></li>
                        <li><a href="#"><strong>[2]</strong>张恒偷郑爽卵子代孕</a></li>
                        <li><a href="#"><strong>[3]</strong>华晨宇：我们是有一个孩子！</a></li>
                        <li><a href="#"><strong>[4]</strong>女:来姨妈 直男:多喝热水 渣男:三个字</a></li>
                        <li><a href="#"><strong>[5]</strong>皮皮龙科目三竟一把过</a></li>--%>
                            <li><a href="#"><strong style="color: red">[TOP1]</strong>年货节必囤零食</a></li>
                            <li><a href="#"><strong>[TOP2]</strong>冬季防病毒口罩</a></li>
                            <li><a href="#"><strong>[TOP3]</strong>过年送长辈礼物怎么选</a></li>
                            <li><a href="#"><strong>[TOP4]</strong>复古女孩冬季穿搭</a></li>
                            <li><a href="#"><strong>[TOP5]</strong>疫情期间选购洗手液</a></li>
                    </ul>
                </div>
            </div>
            <div class="lifeservice">
                <ul>
                    <li><a href="#"><i class="service_ico service_ico_huafei"></i>
                        <p>话费</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_feiji"></i>
                        <p>机票</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_dianying"></i>
                        <p>电影票</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_youxi"></i>
                        <p>游戏</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_caipiao"></i>
                        <p>彩票</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_jiayou"></i>
                        <p>加油卡</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_chongdian"></i>
                        <p>酒店</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_ditie"></i>
                        <p>地铁</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_zhifu"></i>
                        <p>众筹</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_money"></i>
                        <p>理财</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_kabao"></i>
                        <p>礼品卡</p></a></li>
                    <li><a href="#"><i class="service_ico service_ico_wendang"></i>
                        <p>文案</p></a></li>
                </ul>
            </div>
            <div class="bargain">
                <a href="#">
                    <img src="images/liling.png">
                </a>
            </div>
        </div>
    </div>
</div>

<!--推荐模块-->
<div class="w">
    <div class="jx" style="padding-top: 20px">
        <img src="images/icon_5.jpg">
        <span class="" style="font-size: 20px">精彩活动</span>
    </div>
    <div class="row paddtop" style="padding-top: 20px">
        <div class="col-md-12">
            <div class="thumbnail">
                <img src="images/seckill.jpg" alt="" height="100%">
            </div>
        </div>
    </div>

    <div>
        <tr>
            <td>
                <a href="https://www.pinduoduo.com/home/sale/">
                    <img src="images/sale.jpg" alt="" width="29%">
                </a>
            </td>
            <td>
                <a href="https://www.pinduoduo.com/home/supermarket/">
                    <img src="images/supermarket.jpg" alt="" width="41%">
                </a>
            </td>
            <td>
                <a href="https://www.pinduoduo.com/home/download/">
                    <img src="images/down.jpg" alt="" width="29%">
                </a>
            </td>
        </tr>
    </div>
</div>

<!--电梯楼模块-->
<div class="floor">
    <!-- 1楼家用电器楼层 -->
    <div class="w jiadian">
        <div class="box_hd">
            <ul>
                <li>家用电器</li>
            </ul>

            <div class="tab_list">
                <ul>
                    <li><a href="#" class="style_red">热门</a>|</li>
                    <li><a href="#">大家电</a>|</li>
                    <li><a href="#">生活电器</a>|</li>
                    <li><a href="#">厨房电器</a>|</li>
                    <li><a href="#">生活电器</a>|</li>
                    <li><a href="#">个护健康</a>|</li>
                    <li><a href="#">应季电器</a>|</li>
                    <li><a href="#">空气/净水</a>|</li>
                    <li><a href="#">新奇特</a>|</li>
                    <li><a href="#"> 高端电器</a></li>
                </ul>
            </div>
        </div>
        <div class="box_bd">

            <div class="tab_content">
                <div class="tab_list_item">
                    <div class="col_210">
                        <ul>
                            <li><a href="#">良品铺子</a></li>
                            <li><a href="#">百草味</a></li>
                            <li><a href="#">三只松鼠</a></li>
                            <li><a href="#">拉面说</a></li>
                            <li><a href="#">辣翻天</a></li>
                            <li><a href="#">卫龙食品</a></li>
                        </ul>
                        <a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=1">
                            <img src="goods/jiadian_xiaomi_001.jpg" alt="">
                        </a>
                    </div>
                    <div class="col_329">
                        <a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=4">
                            <img src="images/xiaomi.png" alt="" name="xiaomi">
                        </a>
                    </div>
                    <div class="col_221">
                        <a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=${p.pid}"
                           class="bb"> <img src="images/floor-1-2.png" alt=""></a>
                        <a href="#"> <img src="images/floor-1-3.png" alt=""></a>
                    </div>
                    <div class="col_221">
                        <a href="#"> <img src="images/floor-1-4.png" alt=""></a>

                    </div>
                    <div class="col_219">
                        <a href="#" class="bb"> <img src="images/floor-1-5.png" alt=""></a>
                        <a href="#"> <img src="images/floor-1-6.png" alt=""></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--热门商品--%>
    <%--<div class="container-fluid">
        <div class="col-md-12">
            <h2>热门商品&nbsp;&nbsp;<img src="img/title2.jpg"/></h2>
        </div>
        <div class="col-md-2" style="border:1px solid #E7E7E7;border-right:0;padding:0;">
            <img src="products/hao/big01.jpg" width="205" height="404"
                 style="display: inline-block;"/>
        </div>
        <div class="col-md-10">
            <div class="col-md-6" style="text-align:center;height:200px;padding:0px;">
                <a href="product_info.htm">
                    <img src="products/hao/middle01.jpg" width="516px" height="200px"
                         style="display: inline-block;">
                </a>
            </div>
            <c:forEach items="${hList}" var="p">
                &lt;%&ndash;<div class="col-md-2" style="text-align: center;height: 200px;padding: 10px 0px;">
                    <img src="goods/${p.pimages}" width="130" height="130" style="display: inline-block;" >
                </div>&ndash;%&gt;
                <div class="col-md-2" style="text-align:center;height:200px;padding:10px 0px;">
                    <a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=${p.pid}">
                        <img src="goods/${p.pimages}" width="130" height="130" style="display: inline-block;">
                    </a>
                    <p><a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=${p.pid}"
                          style='color:#666'>${fn:substring(p.pname,0,10) }..</a></p>
                    <p><font color="#E4393C" style="font-size:16px">&yen;${p.good_price }</font></p>
                </div>
            </c:forEach>
        </div>
    </div>--%>
    <div class="w jiadian">
        <div class="box_hd">
            <ul>
                <li>热卖商品</li>
            </ul>
        </div>
        <div class="box_bd2">
            <div class="tab_content">
                <div class="tab_list_item">
                    <div class="hot_left" >
                        <a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=1">
                            <img src="goods/left.png" alt="">
                        </a>
                    </div>
                </div>
                <div class="hot_mid" >
                    <a href="#">
                        <img src="products/hao/top.png" width="489px" height="205px"
                             style="display: inline-block;">
                    </a>
                </div>
                <c:forEach items="${hList}" var="p">
                    <div class="hot_goods">
                        <a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=${p.pid}">
                            <img src="goods/${p.pimages}" width="152" height="138" style="display: inline-block;">
                        </a>
                        <p><a href="${pageContext.request.contextPath}/productServlet?method=getById&gid=${p.pid}"
                              style='color:#666'>${fn:substring(p.pname,0,15) }..</a></p>
                        <p><font color="#E4393C" style="font-size:16px">&yen;${p.good_price }</font></p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

</div>
<!--底部模块-->
<div id="shopping_foot"></div>
</body>
</html>
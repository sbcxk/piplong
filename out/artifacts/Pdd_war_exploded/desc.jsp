<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>订单详情</title>

    <!--引入图标-->
    <link rel="shortcut icon" href="favicon.ico"/>
    <!--引入初始化样式文件-->
    <link rel="stylesheet" href="css/pdd_init.css">
    <!--引入注册页面css-->
    <link rel="stylesheet" href="css/login.css">

    <link rel="stylesheet" type="text/css" href="css/shopping-order.css" />

    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <!--引入公共的样式文件-->
    <link rel="stylesheet" href="css/commons.css">
    <script src="js/jquery-3.2.1.min.js"></script>

    <style>
        body {
            margin-top: 20px;
            margin: 0 auto;
        }

        .carousel-inner .item img {
            width: 100%;
            height: 300px;
        }
        .combined{
            width: 1140px;
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            height: 70px;
            position: relative;
        }
        .combined-button{
            font-size: 14px;
        }
        .cost{
            /*width: 171px;*/
            height: 70px;
            margin: 0 30px;
        }
        .cost .shang{
            margin-top: 12px;
        }
        .cost .cost-cost{
            font-size: 14px;
            vertical-align: middle;
        }
        .cost .cost-price{
            font-size: 20px;
            font-weight: 700;
            color: #BE4141;
            vertical-align: middle;
        }
        .cost .cost-price1{
            font-size: 20px;
            font-weight: 700;
            color: #BE4141;
            vertical-align: middle;
        }
        .combined-button{
            font-size: 14px;
        }
        .combined-button button{
            border-radius: 0;
            width: 140px;
            height: 70px;
            margin-top: -1px;
            margin-right: -1px;
            font-size: 18px;
            color: #fff;
            border: 1px solid #b4a078;
            background-color: #b4a078;
            letter-spacing: normal;
            cursor: pointer;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<%@include file="top.jsp" %>
<hr style="border-bottom: 2px solid #b1191a;">
<div class="container">
    <div class="row">
            <div class="w-panelfoot">
                    <%-- 订单项的状态栏 --%>
                <div class="Commodity-information">
                    <div class="w-w2 fl">
                        <span class="all fl"><a style="color: red">订单编号：</a>${order.oid }</span>
                        <div class="clear"></div>
                    </div>
                    <div class=" fl" style="margin-left: 50px">
                        <span class="all" >
                            <a style="color: red">下单时间：</a>
                            <fmt:formatDate value="${order.ordertime }" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                    </div>
                    <div class="w-w5 fr" style="margin-right: 120px">
                        <span class="all fr"><a style="color: red">状态：</a>
                            <c:if test="${order.state == 0 }">待付款</c:if>
                            <c:if test="${order.state == 1 }">待发货</c:if>
                            <c:if test="${order.state == 2 }">待收货</c:if>
                            <c:if test="${order.state == 3 }">已完成</c:if>
                        </span>
                    </div>
                    <div class="w-w6 fr">
                        <span class="all fl"><a style="color: red">收件人：</a>${order.name }&nbsp;</span>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="information">

                        <%-- 订单信息 --%>
                    <div class="Commodity-information">
                        <div class="w-w2 fl">
                            <span class="all fl">商品信息</span>
                            <div class="clear"></div>
                        </div>
                        <div class="w-w3 fl">
                            <span class="all">单价</span>
                        </div>
                        <div class="w-w4 fr">
                            <span class="all">小计</span>
                        </div>

                        <div class="w-w5 fr">
                            <span class="all fr">数量</span>
                        </div>

                        <div class="clear"></div>
                    </div>

                </div>
                    <%--订单--%>
                <ul class="cart-grouplist">
                    <c:forEach items="${order.orderItemList }" var="oi">
                        <li>
                            <div class="list-list">
                                <div class="photo fl">
                                    <img src="goods/${oi.product.pimages}" />
                                </div>
                                <div class="nameCon fl">
                                    <p  class="sleep-yi" href="#">${oi.product.pname}</p>
                                    <div class="color">
                                        <p  href="#">${oi.product.pdesc}</p>
                                    </div>
                                </div>
                                <span class="priceb fl">￥&nbsp;${oi.product.good_price}</span>
                                <span class="reduction fr">￥&nbsp;${oi.subtotal }</span>
                                <span class="price1 fr">${oi.count }</span>

                            </div>
                        </li>
                    </c:forEach>
                </ul>

            </div>

    </div>


        <c:if test="${btn eq 'cancel'}">
            <div class="combined">
                <div class="combined-button fr" >
                    <a href="${pageContext.request.contextPath }/OrderItemServlet?method=cancel&oid=${order.oid }">
                        <button  >取&nbsp;&nbsp;消&nbsp;&nbsp;订&nbsp;&nbsp;单</button>
                    </a>
                </div>
            </div>
            <br>
        </c:if>
        <c:if test="${btn eq 'confirm'}">
            <div class="combined">
                <div class="combined-button fr" >
                    <a href="${pageContext.request.contextPath }/OrderItemServlet?method=confirm&oid=${order.oid }">
                        <button id="btn1" >确&nbsp;&nbsp;认&nbsp;&nbsp;收&nbsp;&nbsp;货</button>
                    </a>
                </div>
            </div>
            <br>
        </c:if>
        <c:if test="${order.state eq 0 and btn ne 'cancel'}">
            <div class="combined">
                <div class="combined-button fr" >
                    <a href="${pageContext.request.contextPath }/OrderItemServlet?method=paymentPre&oid=${order.oid }">
                        <button >立&nbsp;&nbsp;即&nbsp;&nbsp;支&nbsp;&nbsp;付</button>
                    </a>
                </div>
                <div class="cost fr">
                    <div class="shang">
                        <span class="cost-cost">应付总额：</span>
                        <span class="cost-price1">￥</span>
                        <span type="text" class="cost-price"  >${order.total }</span>
                    </div>

                </div>
                <div class="activity fr">
                    <div class="activity-line">

                    </div>
                    <div class="activitylist-line">

                    </div>
                </div>
                <div class="clear"></div>
            </div>

        </c:if>

</div>
</div>

<iframe src="bottom.jsp" width="100%" height="400" scrolling="no" frameborder="0"></iframe>
</body>
</html>

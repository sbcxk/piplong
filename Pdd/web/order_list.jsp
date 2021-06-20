<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>我的订单</title>

    <!--引入图标-->
    <link rel="shortcut icon" href="favicon.ico"/>
    <!--引入初始化样式文件-->
    <link rel="stylesheet" href="css/pdd_init.css">
    <!--引入注册页面css-->
    <link rel="stylesheet" href="css/login.css">
    <!--引入公共的样式文件-->
    <link rel="stylesheet" href="css/commons.css">
    <link rel="stylesheet" type="text/css" href="css/shopping-order.css" />
    <style>
        body {
            margin-top: 20px;
            margin: 0 auto;
        }

        .carousel-inner .item img {
            width: 100%;
            height: 300px;
        }
    </style>
</head>
<body>
<%@include file="top.jsp" %>
<hr style="border-bottom: 2px solid #b1191a;">
<div class="container">
    <div class="row">
    <c:forEach items="${pb.list }" var="o">
        <div class="w-panelfoot">
                <%-- 订单项的状态栏 --%>
            <div class="Commodity-information">
                <div class="w-w2 fl">
                    <span class="all fl"><a style="color: red">订单编号：</a><a href="${pageContext.request.contextPath }/OrderItemServlet?method=load&oid=${o.oid}">${o.oid }</a></span>
                    <div class="clear"></div>
                </div>
                <div class=" fl" style="margin-left: 15px">
                    <span class="all"><a style="color: red">收件人：</a>${o.name==null? "未填写":o.name }</span>
                </div>
                <div class=" fl" style="margin-left: 30px">
                    <span class="all" style="width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
                        <a style="color: red">收货地址：</a>
                        ${o.address==null? "未填写":o.address }
                    </span>
                </div>
                <div class="w-w5 fr" style="margin-right: 120px">
                        <span class="all fr"><a style="color: red">状态：</a>
                            <c:if test="${o.state == 0 }"><a href="${pageContext.request.contextPath }/getByIdServlet?method=doPost&oid=${o.oid}">已下单，点击前往付款</a></c:if>
                            <c:if test="${o.state == 1 }"><a href="${pageContext.request.contextPath }/payMoneyServlet?method=doPost&oid=${o.oid}">已付款，点击前往发货</a></c:if>
                            <c:if test="${o.state == 2 }"><a href="${pageContext.request.contextPath }/confirmServlet?method=doPost&oid=${o.oid}">确认收货</a></c:if>
                            <c:if test="${o.state == 3 }">已完成</c:if>
                            <c:if test="${o.state == 5 }"><a >订单已取消</a></c:if>
                        </span>
                </div>
                <div class="w-w6 fr">
                    <span class="all fl"><a style="color: red">总金额：</a>${o.total }&nbsp;元</span>
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
                    <div class="w-w4 fr">
                        <span class="all ">操作</span>
                    </div>
                    <div class="w-w5 fr">
                        <span class="all fr">数量</span>
                    </div>

                    <div class="clear"></div>
                </div>

            </div>
            <%--订单--%>
            <ul class="cart-grouplist">
                <c:forEach items="${o.items }" var="oi">
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
                        <span class="price1 fr">￥&nbsp;${oi.subtotal }</span>
                        <span class="priceb fl">￥&nbsp;${oi.product.good_price}</span>
                        <span class="reduction fr" style="height: 40px">
                            <a class="sleep-yi" href="${pageContext.request.contextPath }/OrderItemServlet?method=load&oid=${o.oid}">查看订单</a><br>
                                <c:if test="${o.state != 3 and o.state != 5}">
                                    <a class="sleep-yi" href="${pageContext.request.contextPath }/OrderItemServlet?method=load&oid=${o.oid}&btn=cancel">取消订单</a><br>
                                </c:if>
                                <c:if test="${o.state == 0}">
                                    <a class="sleep-yi" href="${pageContext.request.contextPath }/OrderItemServlet?method=load&oid=${o.oid}">支付订单</a><br>
                                </c:if>
                                <c:if test="${o.state == 2}">
                                    <a class="sleep-yi" href="${pageContext.request.contextPath }/OrderItemServlet?method=load&oid=${o.oid}&btn=confirm">确认收货</a>
                                </c:if>
                        </span>

                        <div class="price1 fr" >

                                ${oi.count }
                        </div>

                    </div>
                </li>
                </c:forEach>
            </ul>
            <%--<div style="margin:0 auto; margin-top:10px;width:950px;">
                <strong>我的订单</strong>
                <table class="table table-bordered">
                    <c:forEach items="${pb.list }" var="o">
                        <tbody>
                        <tr class="success">
                            <th colspan="2">订单编号:${o.oid } </th>
                            <th colspan="1">
                                <c:if test="${o.state == 0 }"><a href="${pageContext.request.contextPath }/getByIdServlet?method=doPost&oid=${o.oid}">去付款</a></c:if>
                                <c:if test="${o.state == 1 }"><a href="${pageContext.request.contextPath }/payMoneyServlet?method=doPost&oid=${o.oid}">已付款</a></c:if>
                                <c:if test="${o.state == 2 }"><a href="${pageContext.request.contextPath }/confirmServlet?method=doPost&oid=${o.oid}">确认收货</a></c:if>
                                <c:if test="${o.state == 3 }">已完成</c:if>
                            </th>
                            <th colspan="2">总金额:${o.total }元 </th>
                        </tr>
                        <tr class="warning">
                            <th>图片</th>
                            <th>商品</th>
                            <th>价格</th>
                            <th>数量</th>
                            <th>小计</th>
                        </tr>
                        <c:forEach items="${o.items }" var="oi">
                            <tr class="active">
                                <td width="60" width="40%">
                                    <input type="hidden" name="id" value="22">
                                    <img src="goods/${oi.product.pimages}" width="70" height="60">
                                </td>
                                <td width="30%">
                                    <a target="_blank">${oi.product.pname}</a>
                                </td>
                                <td width="20%">
                                    ￥${oi.product.good_price}
                                </td>
                                <td width="10%">
                                        ${oi.count }
                                </td>
                                <td width="15%">
                                    <span class="subtotal">￥${oi.subtotal }</span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </c:forEach>

                </table>
            </div>--%>
        </div>
    </c:forEach>
    </div>
    <%@include file="page.jsp" %>
</div>

<iframe src="bottom.jsp" width="100%" height="400" scrolling="no" frameborder="0"></iframe>
</body>
</html>

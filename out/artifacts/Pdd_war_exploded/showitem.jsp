<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>订单显示</title>

    <!--引入图标-->
    <link rel="shortcut icon" href="favicon.ico"/>
    <!--引入初始化样式文件-->
    <link rel="stylesheet" href="css/pdd_init.css">
    <!--引入页面css-->
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" type="text/css" href="css/shopping-cars.css"/>
    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <!--引入公共的样式文件-->
    <link rel="stylesheet" href="css/commons.css">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/top.js"></script>
    <script src="js/foot.js"></script>

    <!-- 引入自定义css文件 style.css -->

    <style>


        .carousel-inner .item img {
            width: 100%;
            height: 300px;
        }

        .container .row div {
            /* position:relative;
 float:left; */
        }

        font {
            color: #3164af;
            font-size: 18px;
            font-weight: normal;
            padding: 0 10px;
        }

    </style>

</head>

<body>


<%@include file="top.jsp" %>
<hr style="border-bottom: 2px solid #b1191a;">
<form class="form-horizontal" id="form1"  method="post" action="${pageContext.request.contextPath}/OrderItemServlet">
    <input type="hidden" name="cartItemIds" value="${cartItemIds }"/>
    <input type="hidden" name="method" value="createOrder"/>
<div class="container">
    <div class="row">
        <div class="list">
                <div class="information">
                    <div class="Commodity-information">
                        <div class="w-w1 fl">
                            <%--<input type="checkbox" class="checkbox fl" id="selectAll" name="selectAll" checked="checked"/>--%>
                            <span class="all fl" for="selectAll">生成订单</span>
                            <div class="clear"></div>
                        </div>
                        <div class="w-w2 fl">
                            <span class="all fl">商品信息</span>
                            <div class="clear"></div>
                        </div>
                        &nbsp;&nbsp;&nbsp;
                        <div class="w-w3 fl">
                            <span class="all">单价</span>
                        </div>
                        <div class="w-w4 fl">
                            <span class="all">数量</span>
                        </div>
                        <div class="w-w5 fl">
                            <span class="all fl">小计</span>
                            <div class="clear"></div>
                        </div>
                        <div class="w-w6 fr">
                            <span class="all fl">&nbsp;</span>
                            <div class="clear"></div>
                        </div>

                        <div class="clear"></div>
                    </div>
                </div>
                <ul class="cart-grouplist">

                    <c:forEach items="${cartItemList}" var="cartItem">
                        <li>
                            <div class="list-list">
                                <div class="buttona fl">

                                </div>
                                <div class="photo fl">
                                    <img src="goods/${cartItem.product.pimages}"/>
                                </div>
                                <div class="nameCon fl">
                                    <a class="sleep-yi" href="#">${cartItem.product.pname}</a>
                                    <div class="color">
                                        <a href="#">${cartItem.product.pdesc}</a>
                                    </div>
                                </div>
                                <span class="priceb fl">&nbsp;</span>
                                <span class="pricea fl">￥</span>
                                <span class="priceb fl">${cartItem.product.good_price}</span>

                                <div class="u-selnum fl">
                                    <%--<input class="j-input fl"  value="" id="${cartItem.cartItemId}Count"/>--%>
                                    <input type="text" readonly="readonly">${cartItem.count}
                                    <div class="clear"></div>
                                </div>

                                <span class="price11 fl">￥</span>
                                <span class="price1 fl" id="${cartItem.cartItemId}Subtotal">${cartItem.subtotal }</span>
                                <div class="move-del fl">

                                    <div class="clear"></div>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </li>
                    </c:forEach>

                </ul>

                <%--提交方法--%>
                <input type="hidden" name="method" value="doPost">
                <%--订单号--%>
                <input type="hidden" name="oid" value="${bean.oid}">
                <div class="form-group">
                    <label for="address"  class="col-sm-1 control-label">地址</label>
                    <div class="col-sm-5">
                        <input type="text" name="address" class="form-control" id="address" placeholder="请输入收货地址" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label for="name" class="col-sm-1 control-label">收货人</label>
                    <div class="col-sm-5">
                        <input type="text" name="name" class="form-control" id="name" placeholder="请输收货人" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label for="telephone" class="col-sm-1 control-label">电话</label>
                    <div class="col-sm-5">
                        <input type="text" name="telephone" class="form-control" id="telephone" placeholder="请输入联系方式" maxlength="20">
                    </div>
                </div>

                <div class="combined">
                    <div class="combined-del">
                            <%--<input type="checkbox" class="checkbox"/>--%>

                        <%--<p class="batch-del" href="javascript:void(0);" onclick="batchDelete()">删除选中</p>--%>

                    </div>
                    <div class="combined-button fr" >
                            <%--<a href="${pageContext.request.contextPath }/orderServlet">
                                <button id="btn">下&nbsp;&nbsp;单</button>
                            </a>--%>
                        <a href="javascript:$('#form1').submit();">
                            <button id="btn" >提&nbsp;&nbsp;交&nbsp;&nbsp;订&nbsp;&nbsp;单</button>
                        </a>
                    </div>

                    <div class="cost fr">
                        <div class="shang">
                            <span class="cost-cost">应付总额：</span>
                            <span class="cost-price1">￥</span>
                            <span type="text" class="cost-price" id="total" >${total}</span>
                        </div>
                        <div class="line-line fr">
                            <a href="goods-details.html">
                                <span>再购</span>
                                <span>0.00</span>
                                <span>免邮，去凑单></span>
                            </a>
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
            </div>
    </div>
</div>
</form>
<div id="shopping_foot"></div>
</body>
</html>
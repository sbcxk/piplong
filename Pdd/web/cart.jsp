<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>购物车</title>

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
    <script src="js/myCar.js" type="text/javascript"></script>
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
    <script type="text/javascript">

        /*单个删除*/
        function removeFromCart(ccid) {
            if (confirm("您忍心抛弃我吗?")) {
                location.href = "${pageContext.request.contextPath}/CartItemServlet?method=batchDelete&cartItemIds=" + ccid;
            }
        }
        function batchDelete() {
            // 1. 获取所有被选中条目的复选框
            // 2. 创建一数组，把所有被选中的复选框的值添加到数组中
            // 3. 指定location为CartItemServlet，参数method=batchDelete，参数cartItemIds=数组的toString()
            var cartItemIdArray = new Array();
            $(":checkbox[name=checkboxBtn]").each(function() {
                if(this.checked){
                    cartItemIdArray.push($(this).val());//把复选框的值添加到数组中
                }

            });
            //alert(cartItemIdArray);
            if (confirm("您忍心抛弃我们吗?")) {
                location.href = "${pageContext.request.contextPath}/CartItemServlet?method=batchDelete&cartItemIds=" + cartItemIdArray;
            }

        }

    </script>
</head>

<body>


<%@include file="top.jsp" %>
<hr style="border-bottom: 2px solid #b1191a;">
<div class="container">
    <div class="row">
        <c:if test="${empty cartItemList }">
            <h3>芜湖！购物车的肚子空空如也，赶紧来填饱我吧@_@</h3>

        </c:if>
        <c:if test="${not empty cartItemList}">
            <%--<div style="margin:0 auto; margin-top:10px;width:950px;">
                <strong style="font-size:16px;margin:5px 0;">购物车详情</strong>
                <table class="table table-bordered">
                    <tbody>
                    <tr class="warning">
                        <th>图片</th>
                        <th>商品</th>
                        <th>价格</th>
                        <th>数量</th>
                        <th>小计</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${cart.cartItems }" var="ci">
                        <tr class="active">
                            <td width="60" width="40%">
                                <input type="hidden" name="id" value="22">
                                <img src="goods/${ci.product.pimages}" width="70" height="60">
                            </td>
                            <td width="30%">
                                <a target="_blank">${ci.product.pname}</a>
                            </td>
                            <td width="20%">
                                ￥${ci.product.good_price}
                            </td>
                            <td width="10%">
                                <input type="text" readonly="readonly" name="quantity" value="${ci.count }"
                                       maxlength="4" size="10">
                            </td>
                            <td width="15%">
                                <span class="subtotal">￥${ci.subtotal }</span>
                            </td>
                            <td>
                                <a href="javascript:void(0);" onclick="removeFromCart('${ci.product.pid}')"
                                   class="delete">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div style="margin-right:130px;">
                <div style="text-align:right;">
                    商品金额: <strong style="color:#ff6600;">￥${cart.total }元</strong>
                </div>
                <div style="text-align:right;margin-top:10px;margin-bottom:10px;">
                    <a href="${pageContext.request.contextPath }/cartDelAllServlet?method=doPost" id="clear"
                       class="clear">清空购物车</a>
                    <a href="${pageContext.request.contextPath }/orderServlet">
                        <input type="button" width="100" value="提交订单" name="submit" border="0" style="background: url('images/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
                        height:35px;width:100px;color:white;">
                    </a>
                </div>
            </div>--%>
            <div class="list">
                <div class="information">
                    <div class="Commodity-information">
                        <div class="w-w1 fl">
                            <input type="checkbox" class="checkbox fl" id="selectAll" name="selectAll" checked="checked"/>
                            <span class="all fl" for="selectAll">全选</span>
                            <div class="clear"></div>
                        </div>
                        <div class="w-w2 fl">
                            <span class="all fl">商品信息</span>
                            <div class="clear"></div>
                        </div>
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
                            <span class="all fl">操作</span>
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
                                <input type="checkbox" class="checkbox" name="checkboxBtn" checked="checked" value="${cartItem.cartItemId}"/>
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
                            <span class="pricea fl">￥</span>
                            <span class="priceb fl">${cartItem.product.good_price}</span>
                            <div class="u-selnum fl">

                                <a class="reduction fl" id="${cartItem.cartItemId}Jian">-</a>
                                <input class="j-input fl" type="text" readonly="readonly" value="${cartItem.count}" id="${cartItem.cartItemId}Count"/>
                                <a class="sign fl" id="${cartItem.cartItemId}Jia">+</a>
                                <div class="clear"></div>

                            </div>
                            <span class="price11 fl">￥</span>
                            <span class="price1 fl" id="${cartItem.cartItemId}Subtotal">${cartItem.subtotal }</span>
                            <div class="move-del fl">
                                <a class="delect" href="javascript:void(0);" onclick="removeFromCart('${cartItem.cartItemId}')">
                                    删除商品
                                </a>
                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </li>
                    </c:forEach>

                </ul>

                <div class="combined">
                    <div class="combined-del">
                        <%--<input type="checkbox" class="checkbox"/>--%>

                        <p class="batch-del" href="javascript:void(0);" onclick="batchDelete()">删除选中</p>

                    </div>
                    <div class="combined-button fr" >
                        <%--<a href="${pageContext.request.contextPath }/orderServlet">
                            <button id="btn">下&nbsp;&nbsp;单</button>
                        </a>--%>
                            <a href="javascript:order()">
                                <button id="btn">结&nbsp;&nbsp;算</button>
                            </a>
                    </div>
                    <form id="orderForm" action="<c:url value='/CartItemServlet'/>" method="post">
                        <input type="hidden" name="cartItemIds" id="cartItemIds"/>
                        <input type="hidden" name="total" id="hiddenTotal"/>
                        <input type="hidden" name="method" value="loadCartItems"/>
                    </form>
                    <div class="cost fr">
                        <div class="shang">
                            <span class="cost-cost">应付总额：</span>
                            <span class="cost-price1">￥</span>
                            <span type="text" class="cost-price" id="total"></span>
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
        </c:if>
    </div>
</div>

<div id="shopping_foot"></div>
</body>
</html>
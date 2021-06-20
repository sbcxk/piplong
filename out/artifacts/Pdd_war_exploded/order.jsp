<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>订单</title>

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
        <div class="w-panelfoot">
            <%-- 订单项的状态栏 --%>
            <div class="Commodity-information">
                <div class="w-w2 fl">
                    <span class="all fl"><a style="color: red">订单编号：</a>${bean.oid }</span>
                    <div class="clear"></div>
                </div>

                <div class=" fl" style="margin-left: 50px">
                    <span class="all" >
                        <a style="color: red">下单时间：</a>
                        <fmt:formatDate value="${bean.ordertime }" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </span>
                </div>
                <div class="w-w5 fr" style="margin-right: 120px">
                        <span class="all fr"><a style="color: red">状态：</a>
                            <c:if test="${bean.state == 0 }">待付款</c:if>
                            <c:if test="${bean.state == 1 }">待发货</c:if>
                            <c:if test="${bean.state == 2 }">待收货</c:if>
                            <c:if test="${bean.state == 3 }">已完成</c:if>
                        </span>
                </div>
                <div class="w-w6 fr">
                    <span class="all fl"><a style="color: red">总金额：</a>${bean.total }&nbsp;元</span>
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
                <c:forEach items="${bean.items }" var="oi">
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

        <%--<div style="margin:0 auto;margin-top:10px;width:950px;">
            <strong>订单详情</strong>
            <table class="table table-bordered">
                <tbody>
                <tr class="warning">
                    <th colspan="2">订单编号:${bean.oid } </th>
                    <th colspan="1">
                        <c:if test="${bean.state == 0 }">去付款</c:if>
                        <c:if test="${bean.state == 1 }">已付款</c:if>
                        <c:if test="${bean.state == 2 }">确认收货</c:if>
                        <c:if test="${bean.state == 3 }">已完成</c:if>
                    </th>
                    <th colspan="2">时间:<fmt:formatDate value="${bean.ordertime }" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </th>
                </tr>
                <tr class="warning">
                    <th>图片</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
                <c:forEach items="${bean.items }" var="oi">
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
                                ${oi.count}
                        </td>
                        <td width="15%">
                            <span class="subtotal">￥${oi.subtotal}</span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>--%>

        <%--<div style="text-align:right;margin-right:120px;">
            商品金额: <strong style="color:#ff6600;">￥${bean.total }元</strong>
        </div>--%>

    </div>

    <div>
        <hr/>
        <form class="form-horizontal"id="orderForm" style="margin-top:5px;margin-left:150px;" method="post" action="${pageContext.request.contextPath}/payMoneyServlet">
            <%--提交方法--%>
            <input type="hidden" name="method" value="doPost">
            <%--订单号--%>
            <input type="hidden" name="oid" value="${bean.oid}">
            <div class="form-group">
                <label for="address"  class="col-sm-1 control-label">地址</label>
                <div class="col-sm-5">
                    <input type="text" name="address" class="form-control" id="address" placeholder="请输入收货地址">
                </div>
            </div>
            <div class="form-group">
                <label for="name" class="col-sm-1 control-label">收货人</label>
                <div class="col-sm-5">
                    <input type="text" name="name" class="form-control" id="name" placeholder="请输收货人">
                </div>
            </div>
            <div class="form-group">
                <label for="telephone" class="col-sm-1 control-label">电话</label>
                <div class="col-sm-5">
                    <input type="text" name="telephone" class="form-control" id="telephone" placeholder="请输入联系方式">
                </div>
            </div>
                <%--<div class="w-panel">
                    <div class="title-inform">
                        <span>收货信息</span>
                    </div>
                    <div class="bd-table">
                        <div class="bd-tablef">
                            <div class="bd-table-left fl">
                                    <div class="infor-list">
                                        <label for="address" class="infor fl">收货地址：</label>
                                        <textarea placeholder="详细地址，街道、门牌号等" name="address" id="address" cols="30" rows="10" tabindex="6" class="w-textarea fl" data-reactid=".2.1.0.1.0.0.0.1.0.1.0"></textarea>
                                        <div class="clear"></div>
                                    </div>
                                    <div class="consignee-list">
                                        <div class="man">
                                            <label for="name" class="consignee">收货人：</label>
                                            <input type="" name="name" id="name" value="" class="consignee-inp" placeholder="输入地址" datatype='s5-16' errormsg='地址格式错误' nullmsg="请输入地址！" sucmsg='通过验证' />
                                        </div>
                                        <div class="tel">
                                            <label for="telephone" class="iphone">手机号码：</label>
                                            <input type="tel" name="telephone" id="telephone" value="" placeholder="输入手机号" datatype='m' errormsg='手机号格式错误' nullmsg="请输入手机号！" sucmsg='通过验证' class="iphone-inp" />
                                        </div>
                                        <!--	<div class="clear"></div>-->
                                    </div>

                            </div>

                            <div class="clear"></div>
                        </div>
                    </div>
                </div>--%>
        <hr/>

        <%--<div style="margin-top:5px;margin-left:10px;">
            <strong>选择银行：</strong>
            <p>
                <br/>
                &lt;%&ndash;<input type="radio" name="pd_FrpId" value="ICBC-NET-B2C" checked="checked" />通用银行
                <img src="images/bank.png" align="middle" width="10%"/>&ndash;%&gt;

                <input type="radio" name="pd_FrpId" value="BOC-NET-B2C" />中国银行
                &lt;%&ndash;<img src="${pageContext.request.contextPath}/bank_img/bc.bmp" align="middle" />&ndash;%&gt;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="pd_FrpId" value="ABC-NET-B2C" />农业银行
                &lt;%&ndash;<img src="${pageContext.request.contextPath}/bank_img/abc.bmp" align="middle" />&ndash;%&gt;
                <br/>
                <br/>
                <input type="radio" name="pd_FrpId" value="BOCO-NET-B2C" />交通银行
                &lt;%&ndash;<img src="images/bank_img/bcc.bmp" align="middle" />&ndash;%&gt;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="pd_FrpId" value="PINGANBANK-NET" />平安银行
                &lt;%&ndash;<img src="${pageContext.request.contextPath}/bank_img/pingan.bmp" align="middle" />&ndash;%&gt;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="pd_FrpId" value="CCB-NET-B2C" />建设银行
                &lt;%&ndash;<img src="${pageContext.request.contextPath}/bank_img/ccb.bmp" align="middle" />&ndash;%&gt;
                <br/>
                <br/>
                <input type="radio" name="pd_FrpId" value="CEB-NET-B2C" />光大银行
                &lt;%&ndash;<img src="${pageContext.request.contextPath}/bank_img/guangda.bmp" align="middle" />&ndash;%&gt;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="pd_FrpId" value="CMBCHINA-NET-B2C" />招商银行
                &lt;%&ndash;<img src="${pageContext.request.contextPath}/bank_img/cmb.bmp" align="middle" />&ndash;%&gt;

            </p>
            <hr/>
            <p style="text-align:right;margin-right:100px;">
                <a href="javascript:document.getElementById('orderForm').submit();">
                    <img src="images/finalbutton.gif" width="204" height="51" border="0" />
                </a>
            </p>
            <hr/>
        </div>--%>
                <div class="right-itemInfort fr">
                    <div class="goods-together">
                        <span class="goods-together-name">商品合计    ：</span>
                        <span class="goods-together-name-n">￥</span>
                        <span class="goods-together-name-price">${bean.total }元</span>

                    </div>
                    <div class="goods-freight">
                        <span class="goods-freight-fre">运费    ：</span>
                        <span class="goods-freight-m">￥</span>
                        <span class="goods-freight-pic">0.00</span>
                    </div>
                    <div class="lin-4">
                        <span class="money">应付总额    ：</span>
                        <span class="xing">￥</span>
                        <span class="money-mon">${bean.total }元</span>
                    </div>
                    <div class="button-input99">
                        <a href="shopping-pay.jsp"><span>去付款</span></a>
                    </div>
                    <div class="clear"></div>
                </div>
        </form>
    </div>

</div>

<iframe src="bottom.jsp" width="100%" height="400" scrolling="no" frameborder="0"></iframe>
<script src="js/jquery-3.2.1.min.js" type="text/javascript" charset="utf-8"></script>

<!--<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>-->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script type="text/javascript">
    $("form").Validform({
        tiptype: 3,
        datatype: {
            'm': /^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]|17[0-9]{9}$/,
            'password': /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{5,16}$/
        }
    });
</script>

<script type="text/javascript">
    $(".activeIptWrap-list").css("display", "none");
    var flag = true;
    $(".exchange span").click(function() {
        if(flag) {
            $(this).parent().siblings().find(".activeIptWrap-list").css({
                display: 'block'
            });
            flag = false;
        } else {
            $(this).parent().siblings().find(".activeIptWrap-list").css({
                display: 'none'
            });
            flag = true;
        }
    });
</script>
<script type="text/javascript">
    $(".activeIptWrapa").css("display", "none");
    var flag = true;
    $(".exchangea span").click(function() {
        if(flag) {
            $(this).parent().siblings().find(".activeIptWrapa").css({
                display: 'block'
            });
            flag = false;
        } else {
            $(this).parent().siblings().find(".activeIptWrapa").css({
                display: 'none'
            });
            flag = true;
        }
    });
</script>
</body>
</html>

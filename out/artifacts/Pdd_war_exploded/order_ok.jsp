<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>优购付款</title>
    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="css/shopping-pay.css"/>
    <!--引入图标-->
    <link rel="shortcut icon" href="favicon.ico"/>

    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" type="text/css" href="css/shopping-cars.css"/>
    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <!--引入公共的样式文件-->
    <link rel="stylesheet" href="css/commons.css">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/top.js"></script>
    <script src="js/foot.js"></script>
</head>

<body>
<%@include file="top.jsp" %>
<hr style="border-bottom: 2px solid #b1191a;">
<form action="${pageContext.request.contextPath }/OrderItemServlet" method="post" id="form1" target="_top">
    <input type="hidden" name="method" value="payment"/>
    <input type="hidden" name="oid" value="${order.oid }"/>
    <input type="hidden" name="ICBC-NET-B2C" id="ICBC-NET-B2C" value="ICBC-NET-B2C"/>
    <div class="container">
        <div class="title">
            <h2>选择付款方式</h2>
        </div>
        <div class="title-infor">
            <span class="number">交易号：${order.oid}</span>
            <span class="infor-price">实付 :</span>
            <span class="money">￥${order.total}</span>
        </div>
        <div class="title-infor">
            <span class="number">收件人：${order.name}</span>
        </div>
        <div class="title-infor">
            <span class="number">联系方式：${order.telephone}</span>
        </div>
        <div class="title-infor">
            <span class="number">收货地址：${order.address}</span>
        </div>
        <div class="f-margin-bottom">
            <div class="hd">
                <span>支付方式</span>
            </div>
            <div class="bd">
                <div class="m-payMethods">
                    <div class="j-payMethod fl">
                        <div class="w-radio fl">
                            <input type="radio" name="payMethod" value="3">
                        </div>
                        <div class="photo fl">
                            <img src="img/pic-41.png.png"/>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="q-payMethod fl">
                        <div class="w-radio fl">
                            <input type="radio" name="payMethod" value="3">
                        </div>
                        <div class="photo fl">
                            <img src="img/pic-46.png.jpg"/>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="q-payMethod fl">
                        <div class="w-radio fl">
                            <input type="radio" name="payMethod" value="3">
                        </div>
                        <div class="photo fl">
                            <img src="img/pic-45.png.png"/>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="q-payMethod fl">
                        <div class="w-radio fl">
                            <input type="radio" name="payMethod" value="3">
                        </div>
                        <div class="photo fl">
                            <img src="img/pic-44.png.png"/>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="q-payMethod fl">
                        <div class="w-radio fl">
                            <input type="radio" name="payMethod" value="3">
                        </div>
                        <div class="photo fl">
                            <img src="img/pic-43.png.png"/>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <ul class="m-bink">
                <div class="df">

                </div>
                <div class="df-1">

                </div>
                <li class="china-bank">
                    <img src="img/pic-48.png"/>
                    <div class="sdx">
                        <img src="img/pic-60.png"/>
                    </div>
                </li>
                <li class="china-bank"><img src="img/pic-47.png"/>
                    <div class="sdx">
                        <img src="img/pic-60.png"/>
                    </div>
                </li>
                <li class="china-bank"><img src="img/pic-50.png"/>
                    <div class="sdx">
                        <img src="img/pic-60.png"/>
                    </div>
                </li>
                <li class="china-bank"><img src="img/pic-49.png"/>
                    <div class="sdx">
                        <img src="img/pic-60.png"/>
                    </div>
                </li>
                <li class="china-bank"><img src="img/pic-51.png"/>
                    <div class="sdx">
                        <img src="img/pic-60.png"/>
                    </div>
                </li>
                <li class="clear"></li>
            </ul>
        </div>
        <div class="foo">
            <div class="foo-title fr">
                <p>
                    <a href="javascript:void $('#form1').submit();">
                        <button class="xixi">立即付款</button>
                    </a>

                </p>
            </div>
            <div class="clear"></div>
        </div>
        <div class="foo-time">
            <div class="time-item fr">
                <strong id="minute_show">61分</strong>
                <strong id="second_show">00秒</strong>
            </div>
            <div class="time fr">剩余付款时间 :</div>
            <div class="clear"></div>
        </div>
    </div>
</form>


<script type="text/javascript">
    $(document).ready(function () {
        $(".j-payMethod .w-radio input").prop('checked', true);
    });
    /*var i=$(".q-payMethod input").index();*/


    $(".q-payMethod input").click(function () {
        var i = $(this).parents(".q-payMethod").index();
        if (i == 3) {
            $(".m-bink").css("display", "block");
            $(".df").css("display", "block");
            $(".df-1").css("display", "none");
            $(".m-bink li").css({
                border: "0",
                padding: "2px"
            })
            $(".sdx").css({
                display: "none"
            })


        }
        if (i == 4) {
            $(".m-bink").css("display", "block");
            $(".df-1").css("display", "block");
            $(".df").css("display", "none");
            $(".m-bink li").css({
                border: "0",
                padding: "2px"
            })
            $(".sdx").css({
                display: "none"
            })
        }
        if (i == 0 || i == 1 || i == 2) {
            $(".m-bink").css("display", "none");

        }
    });
    $(".j-payMethod input").click(function () {
        $(".m-bink").css("display", "none");
    })
    //			var $arr=$(".m-bink li");
    /*$(".m-bink li").each(function(){
        $(".foo-title button").click(function(){
            console.log(11)
        })
    })*/
    /*$.each($arr,function(index,foo-title button){
        item.click(function(){
            flag=true;
            break;
        });
        if(flag){
            alert(222)
        }else{
            alert(111)
        }
    })*/

    $(".m-bink li").click(function () {
        $(".m-bink li").css({
            border: "0",
            padding: "2px"
        })
        $(".m-bink li .sdx").css({
            display: "none"
        })
        $(this).css({
            border: "2px solid #b4a078",
            padding: "0"
        })
        $(this).find(".sdx").css({
            display: "block"
        })
    })
    $(".xixi").click(function () {
        var i = $(".q-payMethod").index();
        console.log(i)
    })
</script>
<script type="text/javascript">
    var intDiff = parseInt(59); //倒计时总秒数量
    function timer(intDiff) {
        window.setInterval(function () {
            var day = 0,
                hour = 0,
                minute = 0,
                second = 0; //时间默认值
            if (intDiff > 0) {
                minute = Math.floor(intDiff / 60) - (day * 24 * 60) - (hour * 60);
                second = Math.floor(intDiff) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
            }
            if (minute <= 9)
                minute = '6' + minute;
            if (second <= 9)
                second = '0' + second;
            $('#minute_show').html('<s></s>' + minute + '分');
            $('#second_show').html('<s></s>' + second + '秒');
            intDiff--;
        }, 1000);
    }

    $(function () {
        timer(intDiff);
    });
</script>
<div id="shopping_foot"></div>
</body>

</html>
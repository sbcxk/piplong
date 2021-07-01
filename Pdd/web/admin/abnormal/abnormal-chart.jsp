<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>admin</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="../../css/layout.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="../../css/bootstrap.min.css" type="text/css" media="screen"/>
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="../../css/ie.css" type="text/css" media="screen"/>
    <![endif]-->
    <!--引入图标-->
    <link rel="shortcut icon" href="../../favicon.ico"/>
    <script src="../../js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="../../js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../../js/hideshow.js" type="text/javascript"></script>
    <script src="../../js/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../js/jquery.equalHeight.js"></script>
    <!-- 引入 echarts.js -->
    <%--<script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>--%>
    <script type="text/javascript" src="../../js/echarts.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
                Updateday(7);
            }
        );
        $(document).ready(function () {
                $(".tablesorter").tablesorter();
            }
        );
        $(document).ready(function () {

            //When page loads...
            $(".tab_content").hide(); //Hide all content
            $("ul.tabs li:first").addClass("active").show(); //Activate first tab
            $(".tab_content:first").show(); //Show first tab content

            //On Click Event
            $("ul.tabs li").click(function () {

                $("ul.tabs li").removeClass("active"); //Remove any "active" class
                $(this).addClass("active"); //Add "active" class to selected tab
                $(".tab_content").hide(); //Hide all tab content

                var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
                $(activeTab).fadeIn(); //Fade in the active ID content
                return false;
            });

        });
    </script>
    <script type="text/javascript">
        $(function () {
            $('.column').equalHeight();
        });
    </script>


</head>
<body>

<%@include file="../left.jsp" %>
<section id="main" class="column">

    <h4 class="alert_info">欢迎使用异常图表展示功能。</h4>

    <article class="module width_full">
        <header><h3>近七日异常图表</h3></header>
        <div style="margin-bottom: 25px ; ">
            <form class="form-inline" style="text-align: center">

                <button class="btn btn-info">&nbsp;&nbsp;&nbsp;时间&nbsp;&nbsp;&nbsp;</button>
                <select id="select" class="form-control" style="width: 100px" >
                    <option value="3">近3天</option>
                    <option value="7" selected>近7天</option>
                    <option value="10">近10天</option>
                </select>

                <button class="btn btn-success">
                    <a href="javascript:void(0);" onclick="Updateday($('#select').val())" style="color: white">
                        查询
                    </a>
                </button>
            </form>

        </div>
        <div class="module_content" style="display: flex;align-items: center;">

            <div id="mains" style="width: 580px;height:470px;"></div>

            <div id="main2" style="width: 340px;height:340px;margin-left: 80px"></div>

        </div>

    </article>


    <div class="clear"></div>

    <div class="spacer"></div>
</section>


</body>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例

    Updateday(day);

    function Updateday(day) {
        var myChart = echarts.init(document.getElementById('mains'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '仓库异常柱状图'
            },
            tooltip: {},
            legend: {
                data: ['异常数']
            },
            xAxis: {
                data: []
            },
            yAxis: {},
            series: [{
                name: '异常数',
                type: 'bar',
                data: []
            }]
        };
        myChart.setOption(option,true);
        myChart.clear();
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option,true);
        myChart.showLoading();    //数据加载完之前先显示一段简单的loading动画
        var names = [];    //类别数组（实际用来盛放X轴坐标值）
        var nums = [];    //销量数组（实际用来盛放Y坐标值）

        //    饼状图
        var myChart2 = echarts.init(document.getElementById('main2'));

        // 指定图表的配置项和数据

        var option = {
            series: [
                {
                    name: '异常处理状况',
                    type: 'pie',    // 设置图表类型为饼图
                    radius: '55%',  // 饼图的半径，外半径为可视区尺寸（容器高宽中较小一项）的 55% 长度。
                    data: [          // 数据数组，name 为数据项名称，value 为数据项值
                        /*{value:235, name:'视频广告'},
                        {value:274, name:'联盟广告'},
                        {value:310, name:'邮件营销'},
                        {value:335, name:'直接访问'},
                        {value:400, name:'搜索引擎'}*/
                    ]
                }
            ]
        };
        myChart2.setOption(option,true);
        myChart2.clear();
        // 使用刚指定的配置项和数据显示图表。
        myChart2.setOption(option,true);
        myChart2.showLoading();    //数据加载完之前先显示一段简单的loading动画
        var names2 = [];    //类别数组（实际用来盛放X轴坐标值）
        var nums2 = [];    //销量数组（实际用来盛放Y坐标值）
        $.ajax({
            type: "post",
            async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url: "./../../WareHouseServlet",    //请求发送到TestServlet处
            data: {method: "findDate1", day: day},
            dataType: "json",        //返回数据形式为json
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result) {
                    for (var i = 0; i < result.length; i++) {
                        names.push(result[i].date);    //挨个取出类别并填入类别数组
                    }
                    for (var i = 0; i < result.length; i++) {
                        nums.push(result[i].num);    //挨个取出销量并填入销量数组
                    }
                    myChart.hideLoading();    //隐藏加载动画
                    myChart.setOption({        //加载数据图表
                        xAxis: {
                            data: names
                        },
                        series: [{
                            // 根据名字对应到相应的系列
                            name: '异常数',
                            data: nums
                        }]
                    });

                }

            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                alert("柱状图表请求数据失败!");
                myChart.hideLoading();
            }
        })

        $.ajax({
            type: "post",
            async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url: "./../../WareHouseServlet",    //请求发送到TestServlet处
            data: {method: "findDate2", day: day},
            dataType: "json",        //返回数据形式为json
            success: function (result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result) {
                    $.each(result, function (key, values) { //此处我返回的是list<String,map<String,String>>循环map
                        names2.push(values.date);
                        var obj = new Object();
                        obj.name = values.date;
                        obj.value = values.num;
                        nums2.push(obj);
                    });

                    myChart2.hideLoading();    //隐藏加载动画
                    myChart2.setOption({        //加载数据图表
                        legend: {
                            data: names2
                        },
                        series: [{
                            // 根据名字对应到相应的系列
                            name: '异常数',
                            data: nums2
                        }]
                    });

                }

            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                alert("饼状图表请求数据失败!");
                myChart.hideLoading();
            }
        })
    }

</script>

</html>
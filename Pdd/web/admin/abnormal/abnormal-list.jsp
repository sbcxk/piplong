<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>admin</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- 1. 导入CSS的全局样式 -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="../../js/jquery-3.2.1.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="../../js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../../css/layout.css" type="text/css" media="screen"/>
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="../../css/ie.css" type="text/css" media="screen"/>
    <![endif]-->
    <!--引入图标-->
    <link rel="shortcut icon" href="../../favicon.ico"/>

    <script type="text/javascript" src="../../js/jquery.lightbox-0.5.js"></script>
    <link rel="stylesheet" type="text/css" href="../../css/jquery.lightbox-0.5.css" media="screen"/>
    <script src="../../js/hideshow.js" type="text/javascript"></script>
    <script src="../../js/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../js/jquery.equalHeight.js"></script>
    <script src="../../js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="../../layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript">
        /*$(document).ready(function () {
                $(".tablesorter").tablesorter();
            }
        );*/
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
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        $(function () {
            $('.column').equalHeight();
        });
    </script>
    <script>
        function doDelete(id) {
            location.href = "${pageContext.request.contextPath}/WareHouseServlet?method=delAbnormalById&wid=" + id;
        }

        function doUpdate(id) {
            location.href = "${pageContext.request.contextPath}/WareHouseServlet?method=updateAbnormalById&wid=" + id;
        }

        function deleteAbn(id) {
            Swal.fire({
                title: '你确定要删除吗？',
                text: "删除的数据不可恢复！",
                icon: 'warning',
                showCancelButton: true,
                cancelButtonText: '取消',
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '确定'
            }).then((result) => {
                if (result.isConfirmed) {

                    Swal.fire("删除!", "您的异常已被删除！", "success").then(() => {
                        doDelete(id);
                    })
                } else {
                    Swal.fire("取消!", "您的异常是安全的！", "error")
                }
            })
        }

        function updateAbn(id) {
            Swal.fire({
                title: '你确定要更新异常吗？',
                text: "修改的数据不可恢复！",
                icon: 'warning',
                showCancelButton: true,
                cancelButtonText: '取消',
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '确定'
            }).then((result) => {
                if (result.isConfirmed) {

                    Swal.fire("更新!", "您的异常状况已被更新！", "success").then(() => {
                        doUpdate(id);
                    })
                } else {
                    Swal.fire("取消!", "您的异常状况是安全的！", "error")
                }
            })
        }

        function dostart() {
            $.ajax({
                type: "post",
                url: "./../../CameraServlet",
                data: {
                    method: "start"
                },
                //请求成功后的回调函数有两个参数
                success: function (data) {

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("系统错误");
                },
            });

        }

        function dostop() {
            $.ajax({
                type: "post",
                url: "./../../CameraServlet",
                data: {
                    method: "stop"
                },
                //请求成功后的回调函数有两个参数
                success: function (data) {

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("系统错误,请先打开服务");
                },
            });
        }

        function start() {
            Swal.fire({
                title: '你确定要开启异常监测吗？',
                text: "异常监测开启后将加载数据！",
                icon: 'warning',
                showCancelButton: true,
                cancelButtonText: '取消',
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '确定'
            }).then((result) => {
                if (result.isConfirmed) {

                    Swal.fire("开启!", "您的监控已被开启！", "success").then(() => {
                        dostart();
                    })
                } else {
                    Swal.fire("取消!", "您的异常暂未开启！", "error")
                }
            })
        }

        function stop() {
            Swal.fire({
                title: '你确定要关闭异常监测吗？',
                text: "异常监测关闭后将停止载入数据！",
                icon: 'warning',
                showCancelButton: true,
                cancelButtonText: '取消',
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '确定'
            }).then((result) => {
                if (result.isConfirmed) {

                    Swal.fire("关闭!", "您的监控已关闭！", "success").then(() => {
                        dostop();
                    })
                } else {
                    Swal.fire("取消!", "您的监控正常运行！", "error")
                }
            })
        }

        function faceRec(faceImg) {
            //发送ajax
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/WareHouseServlet",
                data: {
                    "method": "faceRec",
                    "faceImg": faceImg
                },
                dataType: 'json',
                //请求成功后的回调函数有两个参数
                success: function (d) {
                    //alert(d);
                    var s = "<table border='1' width='99%'>";
                    //var path="../imgFace/"+d[0].face_img;
                    var path=d[0].face_img;

s = `<table border="1" align="center" cellpadding="10" width="600" >
    <tr>
        <th bgcolor="BurlyWood">姓名</th>
        <td width="100">&nbsp;`+d[0].face_name+`</td>
        <th bgcolor="BurlyWood" >年龄</th>
        <td width="100">&nbsp;&nbsp;`+d[0].face_age+`</td>
        <td rowspan="2" width="100">
            <p >
                <img border="0" src=" `+ path +` " style="width: 250px;height: 250px"/>
            </p>
        </td>
    </tr>
    <tr>
        <th bgcolor="BurlyWood" >职业</th>
        <td width="100">`+d[0].face_post+`</td>
        <th bgcolor="BurlyWood">性别</th>
        <td width="100">&nbsp;&nbsp;`+d[0].face_sex+`</td>
    </tr>
</table>
`
                    layer.open({
                        type: 1,//0:信息框; 1:页面; 2:iframe层;	3:加载层;	4:tip层
                        title: "图片名称:" + faceImg,//标题
                        area: ['650px', '350px'],//大小
                        shadeClose: true, //点击弹层外区域 遮罩关闭
                        content: s//内容
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //alert("人脸匹配系统错误，请联系管理员");
                    Swal.fire("识别错误", "未识别到人脸，请选择其他照片!", "error");

                },
            });
        }
    </script>
    <script type="text/javascript">
        $(function () {
            $('#gallery a').lightBox();
        });
    </script>
    <style type="text/css">
        .demo td, th /*设置表格文字左右和上下居中对齐*/
        {
            text-align: center;
            vertical-align: middle !important;
        }

        /* jQuery lightBox plugin - Gallery style */
        #gallery {
            background-color: #444;
            padding: 10px;
            width: 520px;
        }

        #gallery ul {
            list-style: none;
        }

        #gallery ul li {
            display: inline;
        }

        #gallery ul img {
            border: 5px solid #3e3e3e;
            border-width: 5px 5px 20px;
        }

        #gallery ul a:hover img {
            border: 5px solid #fff;
            border-width: 5px 5px 20px;
            color: #fff;
        }

        #gallery ul a:hover {
            color: #fff;
        }
    </style>

</head>
<body>
<%@include file="../left.jsp" %>
<section id="main" class="column">

    <h4 class="alert_info">欢迎使用异常管理功能。</h4>
    <article class="module width_full">
        <header><h3>仓库异常列表</h3></header>

        <div style="float: left">

            <form class="form-inline" action="${pageContext.request.contextPath}/WareHouseServlet?method=abnormalList"
                  method="post">
                <div class="form-group">
                    <label for="exampleInputName2">&nbsp;&nbsp;&nbsp;时间</label>
                    <input type="date" class="form-control" value="${condition.wdate[0]}" id="exampleInputName2"
                           name="wdate">
                </div>
                <button type="submit" class="btn btn-default">查询</button>
            </form>

        </div>
        <div style="float: right;margin: 5px">

            <a class="btn btn-success" target="_blank" href="http://192.168.43.217:8081/" id="join">进入实时监控</a>
            <a class="btn btn-primary" href="javascript:start();" id="star">开启异常监测</a>
            <a class="btn btn-danger" href="javascript:stop();" id="stop">关闭异常监测</a>

        </div>
        <form id="form" action="${pageContext.request.contextPath}/delSelectedServlet" method="post">

            <table border="1" class="table table-bordered table-hover">
                <tr class="info">
                    <th><input type="checkbox" id="firstCb"></th>
                    <th>序号</th>
                    <th>异常抓拍</th>
                    <th>异常发生时间</th>
                    <th>异常状态</th>
                    <th>操作</th>

                </tr>
                <c:forEach items="${abnormalList.list}" var="abList" varStatus="s">
                    </tr>
                    <tr class='demo'>
                        <th><input type="checkbox" name="uid" value="${abList.wid}"></th>
                        <td>${s.count}</td>
                        <td>
                            <a target="_blank" href="../../imgRaspberry/${abList.wimage}">
                                <img src="../../imgRaspberry/${abList.wimage}" width="70" height="70" id="pimg">
                            </a>

                        </td>
                        <td>
                            <fmt:formatDate value="${abList.wdate}" pattern="yyyy 年 MM 月 dd 日 HH:mm:ss"/>

                        </td>
                        <td>
                            <c:if test="${abList.status == 0 }">待处理</c:if>
                            <c:if test="${abList.status == 1 }">已处理</c:if>
                        </td>
                        <td>
                            <c:if test="${abList.status == 0 }">
                                <a class="btn btn-default btn-sm" href="javascript:updateAbn('${abList.wid}');">处理异常</a>&nbsp;
                            </c:if>
                            <a class="btn btn-default btn-sm" href="javascript:faceRec('${abList.wimage}');">人脸匹配</a>&nbsp;
                            <a class="btn btn-danger btn-sm" style="color: white"
                               href="javascript:deleteAbn('${abList.wid}');">删除
                            </a>
                        </td>
                    </tr>
                </c:forEach>


            </table>
        </form>
        <div>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${abnormalList.currentPage==1}">
                    <li class="disabled">
                        </c:if>
                        <c:if test="${abnormalList.currentPage!=1}">
                    <li>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/WareHouseServlet?method=abnormalList&currentPage=${abnormalList.currentPage-1}&rows=5&wdate=${condition.wdate[0]}"
                           aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>

                    <c:forEach begin="1" end="${abnormalList.totalPage}" var="i">
                        <c:if test="${abnormalList.currentPage==i}">
                            <li class="active"><a
                                    href="${pageContext.request.contextPath}/WareHouseServlet?method=abnormalList&currentPage=${i}&rows=5&wdate=${condition.wdate[0]}">${i}</a>
                            </li>
                        </c:if>
                        <c:if test="${abnormalList.currentPage!=i}">
                            <li>
                                <a href="${pageContext.request.contextPath}/WareHouseServlet?method=abnormalList&currentPage=${i}&rows=5&wdate=${condition.wdate[0]}">${i}</a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${abnormalList.currentPage>=abnormalList.totalPage-1}">
                    <li class="disabled">
                        </c:if>
                        <c:if test="${abnormalList.currentPage<abnormalList.totalPage-1 }">
                    <li>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/WareHouseServlet?method=abnormalList&currentPage=${abnormalList.currentPage+1}&rows=5&wdate=${condition.wdate[0]}"
                           aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <span style="font-size: 25px;margin-left: 5px;">
                    共${abnormalList.totalCount}条记录，共${abnormalList.totalPage}页
                </span>
                </ul>
            </nav>
        </div>
    </article><!-- end of styles article -->
    <div class="spacer"></div>
</section>
</body>
</html>
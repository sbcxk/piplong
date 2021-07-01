<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>分类列表管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="../../css/layout.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="../../css/ie.css" type="text/css" media="screen"/>
    <!--引入图标-->
    <link rel="shortcut icon" href="../../favicon.ico"/>
    <script src="../../js/jquery-1.5.2.min.js" type="text/javascript"></script>
    <script src="../../js/hideshow.js" type="text/javascript"></script>
    <script src="../../js/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../js/jquery.equalHeight.js"></script>
    <script type="text/javascript">
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
<%@include file="../left.jsp"%>
<section id="main" class="column">

    <h4 class="alert_info">欢迎使用分类管理功能。</h4>
    <article class="module width_full">
        <header><h3>编辑分类</h3></header>
        <form action="${pageContext.request.contextPath}/updateCateServlet" method="post">
            <%--隐藏域 提交id--%>
            <input type="hidden" name="cid" value="${cate.cid}">
            <div class="form-group">
                <label for="cname">分类名称：</label>
                <input type="text" class="form-control" id="cname" name="cname"  value=${cate.cname}  placeholder="请输入类名" />
            </div>

            <div class="form-group" style="text-align: center">
                <input class="btn btn-primary" type="submit" value="提交" />
                <button type="reset" value="重置" class="button_cancel">&#37325;&#32622;</button>
                <input class="btn btn-default" type="button" onclick="history.go(-1)" value="返回"/>
            </div>
        </form>

    </article>


    <div class="spacer"></div>
</section>


</body>

</html>
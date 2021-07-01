<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>admin</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="../../css/layout.css" type="text/css" media="screen" />
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="../../css/ie.css" type="text/css" media="screen" />
    <![endif]-->
    <!--引入图标-->
    <link rel="shortcut icon" href="../../favicon.ico"/>
    <script src="../../js/jquery-1.11.3.min.js" type="text/javascript"></script>
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
    <script>
        function deleteCategory(id) {
            //用户安全提示
            if (confirm("宁真的要把我删了吗QWQ？")) {
                //访问路径
                //alert(id);
                location.href = "${pageContext.request.contextPath}/delCateServlet?cid=" + id;
            }
        }

    </script>
</head>
<body>

<%@include file="../left.jsp"%>
<section id="main" class="column">

    <h4 class="alert_info">欢迎使用分类管理功能。</h4>


    <article class="module width_3_quarter">
        <header><h3 class="tabs_involved">分类列表</h3></header>

        <div class="tab_container">
            <div id="tab1" class="tab_content">
                <table class="tablesorter" cellspacing="0">
                    <thead>
                    <tr>
                        <th></th>
                        <th>商品ID</th>
                        <th>类名</th>
                        <th>编辑</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                    <c:forEach var="c" items="${list}" varStatus="vs">
                        <tbody>
                        <tr>
                            <td><input type="checkbox"></td>
                            <td>${vs.count}</td>
                            <td>${c.cname}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/findCateServlet?cid=${c.cid}">
                                    <input type="image" src="../../images/icn_edit.png" title="Edit">
                                </a>
                            </td>
                            <td>

                                <a href="javascript:deleteCategory('${c.cid}');">
                                    <input type="image"src="../../images/icn_trash.png"title="Trash">
                                </a>
                            </td>
                        </tr>
                        </tbody>
                    </c:forEach>

                </table>
            </div><!-- end of #tab1 -->



        </div><!-- end of .tab_container -->

    </article><!-- end of content manager article -->


    <div class="clear"></div>

    <div class="spacer"></div>
</section>


</body>

</html>
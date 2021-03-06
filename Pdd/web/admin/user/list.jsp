<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="../../js/jquery-1.9.1.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="../../js/bootstrap.min.js"></script>
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
        function deleteUser(id) {
            //用户安全提示
            if (confirm("宁真的要把我删了吗QWQ？")) {
                //访问路径
                location.href = "${pageContext.request.contextPath}/delUserServlet?id=" + id;
            }
        }
    </script>

</head>
<body>
<%@include file="../left.jsp"%>

<section id="main" class="column">

    <h4 class="alert_info">欢迎使用查询所有用户功能。</h4>
    <article class="module width_full">
        <header><h3>用户列表</h3></header>
        <%--<form class="form-inline" action="${pageContext.request.contextPath}/findUserByNameServlet" method="post" style="float: right">
            <div class="form-group" >
                <label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
                <div class="input-group">
                    <div class="input-group-addon">用户名</div>
                    <input type="text" class="form-control" id="exampleInputAmount" value="${condition.name[0]}" placeholder="支持模糊搜索" name="name">
                </div>
            </div>
            <button type="submit" class="btn btn-primary" >查询</button>
        </form>
        <form id="Form1" name="Form1" action="${pageContext.request.contextPath}/user/list.jsp" method="post">
            <table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
                <TBODY>
                <tr>
                    <td class="ta_01" align="center" bgColor="#f5fafe">
                        <table cellspacing="0" cellpadding="1" rules="all"
                               bordercolor="gray" border="1" id="DataGrid1"
                               style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
                            <tr
                                    style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

                                <td align="center" width="5%">
                                    序号
                                </td>
                                <td align="center" width="10%">
                                    用户名
                                </td>
                                <td align="center" width="10%">
                                    密码
                                </td>
                                <td align="center" width="15%">
                                    邮箱
                                </td>
                                <td align="center" width="10%">
                                    激活状态
                                </td>
                                <td width="7%" align="center">
                                    编辑
                                </td>
                                <td width="7%" align="center">
                                    删除
                                </td>
                            </tr>
                            <c:forEach items="${sessionScope.list }" var="p" varStatus="vs">
                                <tr onmouseover="this.style.backgroundColor = 'white'"
                                    onmouseout="this.style.backgroundColor = '#F5FAFE';">
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center" width="5%">
                                            ${vs.count}
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center" width="10%">
                                            ${p.username}
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center" width="10%">
                                            ${p.password}
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center" width="15%">
                                            ${p.email}
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center" width="10%">
                                            ${p.status}
                                    </td>
                                    <td align="center" style="HEIGHT: 22px">
                                        <a href="${ pageContext.request.contextPath }/findUserServlet?id=${p.id}">
                                            <img src="../../images/icn_edit.png" border="0" style="CURSOR: hand">
                                        </a>
                                    </td>

                                    <td align="center" style="HEIGHT: 22px">
                                        <a href="javascript:deleteUser(${p.id});">
                                            <img src="../../images/icn_trash.png" width="16" height="16" border="0" style="CURSOR: hand">
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </tr>

                </TBODY>
            </table>
        </form>--%>
        <div style="float: left">

            <form class="form-inline" action="${pageContext.request.contextPath}/findUserByPageServlet" method="post">
                <div class="form-group">
                    <label for="exampleInputName2">姓名</label>
                    <input type="text" class="form-control" value="${condition.username[0]}" id="exampleInputName2" name="username">
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail3">邮箱</label>
                    <input type="text" class="form-control" value="${condition.email[0]}" id="exampleInputEmail3" name="email">
                </div>
                <div class="form-group">
                    <label for="exampleInputName3">激活状态</label>
                    <input type="text" class="form-control" value="${condition.status[0]}" id="exampleInputName3" name="status">
                </div>
                <button type="submit" class="btn btn-default">查询</button>
            </form>

        </div>
        <div style="float: right;margin: 5px">

            <a class="btn btn-primary" href="../../admin/user/add.jsp">添加联系人</a>
            <a class="btn btn-primary" href="javascript:void(0);" id="delSelected">删除选中</a>

        </div>
        <form id="form" action="${pageContext.request.contextPath}/delSelectedServlet" method="post">
            <table border="1" class="table table-bordered table-hover">
                <tr class="success">
                    <th><input type="checkbox" id="firstCb"></th>
                    <th>序号</th>
                    <th>用户名</th>
                    <th>密码</th>
                    <th>邮箱</th>
                    <th>激活状态</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pb.list}" var="user" varStatus="s">
                    </tr>
                    <tr>
                        <th><input type="checkbox" name="uid" value="${user.id}"></th>
                        <td>${s.count}</td>
                        <td>${user.username}</td>
                        <td>${user.password}</td>
                        <td>${user.email}</td>
                        <td>${user.status}</td>
                        <td>
                            <a class="btn btn-default btn-sm"
                               href="${pageContext.request.contextPath}/findUserServlet?id=${user.id}">修改</a>&nbsp;
                            <a class="btn btn-default btn-sm" href="javascript:deleteUser(${user.id});">删除</a>
                        </td>
                    </tr>

                </c:forEach>


            </table>
        </form>
        <div>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${pb.currentPage==1}">
                    <li class="disabled">
                        </c:if>
                        <c:if test="${pb.currentPage!=1}">
                    <li>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/findUserByPageServlet?currentPage=${pb.currentPage-1}&rows=5&username=${condition.username[0]}&email=${condition.email[0]}&status=${condition.status[0]}"
                           aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <c:forEach begin="1" end="${pb.totalPage}" var="i">

                        <c:if test="${pb.currentPage==i}">
                            <li class="active"><a href="${pageContext.request.contextPath}/findUserByPageServlet?currentPage=${i}&rows=5&username=${condition.username[0]}&email=${condition.email[0]}&status=${condition.status[0]}">${i}</a>
                            </li>
                        </c:if>
                        <c:if test="${pb.currentPage!=i}">
                            <li>
                                <a href="${pageContext.request.contextPath}/findUserByPageServlet?currentPage=${i}&rows=5&username=${condition.username[0]}&email=${condition.email[0]}&status=${condition.status[0]}">${i}</a>
                            </li>
                        </c:if>

                    </c:forEach>

                    <c:if test="${pb.currentPage>=pb.totalPage-1}">
                    <li class="disabled">
                        </c:if>
                        <c:if test="${pb.currentPage<pb.totalPage-1 }">
                    <li>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/findUserByPageServlet?currentPage=${pb.currentPage+1}&rows=5&username=${condition.username[0]}&email=${condition.email[0]}&status=${condition.status[0]}"
                           aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <span style="font-size: 25px;margin-left: 5px;">
                    共${pb.totalCount}条记录，共${pb.totalPage}页
                </span>
                </ul>
            </nav>
        </div>
    </article><!-- end of styles article -->
    <div class="spacer"></div>
</section>


</body>

</html>
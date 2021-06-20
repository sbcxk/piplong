<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="zh-CN">
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

    <h4 class="alert_info">欢迎使用用户管理功能。</h4>
    <article class="module width_full">
        <header><h3>编辑用户</h3></header>
        <form action="${pageContext.request.contextPath}/updateUserServlet" method="post">
            <%--隐藏域 提交id--%>
            <input type="hidden" name="id" value="${user.id}">

            <table cellSpacing="1" cellPadding="5" width="100%" align="center" bacgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
                <tr>
                    <td width="18%" align="center" bgColor="#f5fafe" class="ta_01" >
                        用户名：
                    </td>
                    <td class="ta_01" bgColor="#ffffff" colspan="3">
                        <input type="text" name="username" value="${user.username}" id="username" class="bg" disabled=true />
                    </td>

                </tr>
                <tr>
                    <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                        用户密码：
                    </td>
                    <td class="ta_01" bgColor="#ffffff" colspan="3">
                        <input type="text" name="password" value="${user.password}" id="password" class="bg" placeholder="请输密码"/>
                    </td>
                </tr>
                <tr>
                    <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                        Email：
                    </td>
                    <td class="ta_01" bgColor="#ffffff" colspan="3">
                        <input type="text" name="email" value="${user.email}" id="email" class="bg" placeholder="请输入邮箱地址"/>
                    </td>
                </tr>
                <tr>
                    <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                        账户是否激活：
                    </td>
                    <td class="ta_01" bgColor="#ffffff" colspan="3">
                        <select name="status" id="status" value="${user.status}" >

                            <option value="Y" <c:if test="${'Y' eq user.status}">selected</c:if>>是</option>
                            <option value="N" <c:if test="${'N' eq user.status}">selected</c:if>>否</option>
                        </select>
                    </td>
                </tr>
            </table>

            <div class="form-group" style="text-align: center">
                <td class="ta_01" style="WIDTH: 100%" align="center"
                    bgColor="#f5fafe" colSpan="4">
                    <button type="submit" id="userAction_save_do_submit" value="确定" class="button_ok">
                        &#30830;&#23450;
                    </button>

                    <FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
                    <button type="reset" value="重置" class="button_cancel">&#37325;&#32622;</button>

                    <FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
                    <input class="button_ok" type="button" onclick="history.go(-1)" value="返回"/>
                    <span id="Label1"></span>
                </td>
            </div>
        </form>
    </article>


    <div class="spacer"></div>
</section>


</body>

</html>
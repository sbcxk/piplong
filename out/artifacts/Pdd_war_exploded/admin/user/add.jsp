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
</head>
<body>
<%@include file="../left.jsp"%>

<section id="main" class="column">

    <h4 class="alert_info">欢迎使用用户管理功能。</h4>
    <article class="module width_full">
        <header><h3>添加用户</h3></header>
        <div class="container">
            <form id="userAction_save_do" name="Form1" action="${pageContext.request.contextPath}/addUserServlet" method="post" >
                &nbsp;
                <table cellSpacing="1" cellPadding="5" width="100%" align="center" bgColor="#eeeeee" style=" border: 1px solid #8ba7e3" border="0">

                    <tr>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            用户名称：
                        </td>
                        <td class="ta_01" bgColor="#ffffff" colspan="3">
                            <input type="text" name="username" placeholder="请输入用户名" id="username" class="bg"/>
                        </td>
                    </tr>

                    <tr>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            用户密码：
                        </td>
                        <td class="ta_01" bgColor="#ffffff" colspan="3">
                            <input type="password" name="password" placeholder="请输入密码" id="password" class="bg"/>
                        </td>
                    </tr>

                    <tr>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            邮箱地址：
                        </td>
                        <td class="ta_01" bgColor="#ffffff" colspan="3">
                            <input type="email" name="email" placeholder="请输入邮箱地址" id="email" class="bg"/>
                        </td>
                    </tr>

                    <tr>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            用户状态：
                        </td>
                        <td class="ta_01" bgColor="#ffffff" colspan="3">
                            <input type="text" name="status" placeholder="请输入状态(Y/N)" id="status" class="bg"/>
                        </td>
                    </tr>

                    <tr>
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
                    </tr>
                </table>

                <%--<div class="form-group">
                    <label for="username">用户名：</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名">
                </div>

                <div class="form-group">
                    <label for="password">密码：</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
                </div>

                <div class="form-group">
                    <label for="email">邮箱：</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="请输入邮箱">
                </div>

                <div class="form-group" >
                    <label for="status">账号状态：</label>
                    <input type="text" class="form-control" id="status" name="status" placeholder="请输入状态(Y/N)">
                </div>

                <div class="form-group" style="text-align: center">
                    <input class="btn btn-primary" type="submit" value="提交" />
                    <input class="btn btn-default" type="reset" value="重置" />
                    <input class="btn btn-default" type="button" value="返回" />
                </div>--%>
            </form>
        </div>

    </article>


    <div class="spacer"></div>
</section>


</body>

</html>
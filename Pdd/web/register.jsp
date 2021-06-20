<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>个人注册</title>
    <!--引入图标-->
    <link rel="shortcut icon" href="favicon.ico"/>
    <!--引入初始化样式文件-->
    <link rel="stylesheet" href="css/pdd_init.css">
    <!--引入注册页面css-->
    <link rel="stylesheet" href="css/register.css">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        //切换验证码
        function refreshCode(){
            var vcode = document.getElementById("vcode");
            vcode.src="${pageContext.request.contextPath}/checkCodeServlet?time="+new Date().getTime();
        }

        window.onload = function () {
            document.getElementById("form").onsubmit = function () {
                return checkUsername() && checkPassword() && checkEmail();
            }
            //绑定立交事件
            document.getElementById("username").onblur = checkUsername;
            document.getElementById("password").onblur = checkPassword;
            document.getElementById("email").onblur = checkEmail;
        }
    </script>
    <script>

        //校验用户名
        function checkUsername() {
            //获取用户名值
            var username = document.getElementById("username").value;
            var reg_username = /^\w{6,12}$/;
            var flag = reg_username.test(username);
            var s_username = document.getElementById("s_username");
            if (flag){
                //正则通过，校验用户名重复
                //在页面完成后
                $(function (){
                    //给username绑定blur事件
                    $("#username").blur(function (){
                        //获取username文本框输入值
                        var username=$(this).val();
                        //发送ajax
                        /*期待服务器响应的数据格式
                        {"userExsit":true,"msg":"此用户名太受欢迎，请换一个"}
                        {"userExsit":false,"msg":"用户名可用"}*/
                        $.get("findHaveUserServlet",{username:username},function (data){
                            //判断userExsit键值
                            var span=$("#s_username");
                            if(data.userExsit){
                                // 用户名存在
                                //span.css("color","red");
                                span.html(data.msg);
                                flag=0;
                                return flag;
                            }else{
                                //span.css("color","green");
                                //span.html(data.msg);
                            }
                        },"json");
                    })
                })
                s_username.innerHTML = "<img widtn='35' height='25' src='images/gou.png'/>";
            }

            else
                s_username.innerHTML = "用户名格式错误";
            return flag;
        }

        function checkPassword() {
            //获取用户名值
            var password = document.getElementById("password").value;
            var reg_password = /^\w{6,12}$/;
            var flag = reg_password.test(password);
            var s_password = document.getElementById("s_password");
            if (flag)
                s_password.innerHTML = "<img widtn='35' height='25' src='images/gou.png'/>";
            else
                s_password.innerHTML = "密码格式错误";
            return flag;
        }

        function checkEmail() {
            //获取用户名值
            var email = document.getElementById("email").value;
            /*数字开头包含@.2-4个字母结尾*/
            var reg_email = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
            var flag = reg_email.test(email);
            var s_email = document.getElementById("s_email");
            if (flag)
                s_email.innerHTML = "<img widtn='35' height='25' src='images/gou.png'/>";
            else
                s_email.innerHTML = "邮箱格式错误";
            return flag;
        }

    </script>
    <script>

    </script>
</head>
<body>
<div class="w">
    <header>
        <div class="logo">
            <a href="index.jsp"><img src="images/PYG.png" alt=""></a>
        </div>
    </header>
    <div class="registerarea">
        <h3>
            注册新用户
            <div class="login">我有账号，马上<a href="login.jsp">登录</a></div>
        </h3>
        <div class="rg_center" >
            <div class="rg_form" style="color:#A6A6A6;">

                <form action="${pageContext.request.contextPath}/enrollServlet" method="post" id="form">
                    <table >
                        <tr>
                            <td class="td_left" ><label for="username">用户名</label> </td>
                            <td class="td_right"><input type="text" name="username" id="username" placeholder="请输入用户名">
                                <span id="s_username" class="error"></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_left"><label for="password">密码</label> </td>
                            <td class="td_right"><input type="password" name="password" id="password" placeholder="请输入密码">
                                <span id="s_password" class="error"></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_left"><label for="email">邮箱</label> </td>
                            <td class="td_right"><input type="email" name="email" id="email" placeholder="请输入邮箱">
                                <span id="s_email" class="error"></span>
                            </td>
                        </tr>

                        <tr>
                            <td class="td_left"><label for="vcode">验证码</label> </td>
                            <td class="td_right"><input type="text" name="verifycode" id="verifycode" placeholder="请输入验证码">
                                <a href="javascript:refreshCode()">
                                    <img src="${pageContext.request.contextPath}/checkCodeServlet" title="看不清点击刷新" id="vcode"/>
                                </a>
                            </td>
                        </tr>
                        <div class="alert alert-warning alert-dismissible" role="alert" >
                            <button type="button" class="close" data-dismiss="alert" >
                                <span></span></button>
                            <strong></strong>
                        </div>
                        <tr>
                            <td  id="td_sub" colspan="2">
                                <input type="submit" id="btn_sub" value="注册">
                            </td>
                        </tr>

                    </table>
                </form>
            </div>
    </div>

    </div>

</div>
<iframe src="bottom.jsp" width="100%" height="400" scrolling="no" frameborder="0"></iframe>
</body>

<script>
    /*window.alert = function(name){
        var iframe = document.createElement("IFRAME");
        iframe.style.display="none";
        iframe.setAttribute("src", 'data:text/plain');
        document.documentElement.appendChild(iframe);
        window.frames[0].window.alert(name);
        iframe.parentNode.removeChild(iframe);
    }*/
    <c:if test="${regist!=null}">
            window.alert("${regist}");
    </c:if>
</script>
</html>
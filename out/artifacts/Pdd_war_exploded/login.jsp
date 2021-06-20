<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>个人登录</title>

    <!--引入图标-->
    <link rel="shortcut icon" href="favicon.ico"/>
    <!--引入初始化样式文件-->
    <link rel="stylesheet" href="css/pdd_init.css">
    <!--引入注册页面css-->
    <link rel="stylesheet" href="css/login.css">
    <!--引入公共的样式文件-->
    <link rel="stylesheet" href="css/commons.css">
    <!--引入登录页面js-->
    <script src="js/login.js"></script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/jquery.cookie.js"></script>
    <script src="js/jquery.base64.js"></script>
    <script src="js/top.js"></script>
    <script src="js/foot.js"></script>
    <script type="text/javascript">
        //切换验证码
        function refreshCode(){
            var vcode = document.getElementById("vcode");
            vcode.src="${pageContext.request.contextPath}/checkCodeServlet?time="+new Date().getTime();
        }

    </script>
    <script>
        //设置cookie  
        function setCookie(){
            var loginCode = $("#username").val(); //获取用户名信息    
            var pwd = $("#password").val(); //获取登陆密码信息    
            var checked = $("input[type='checkbox']").is(':checked');//获取“是否记住密码”复选框  
            //console.log("setCookie方法是否记住密码："+checked);
            if(checked){ //判断是否选中了“记住密码”复选框    
                //设置cookie过期时间
                var date = new Date();
                date.setTime(date.getTime()+60*1000);//只能这么写，60表示60秒钟
                //console.log("cookie过期时间："+date);
                $.cookie("login_code",loginCode,{ expires: date, path: '/' });//调用jquery.cookie.js中的方法设置cookie中的用户名    
                $.cookie("pwd",$.base64.encode(pwd),{ expires: date, path: '/' });//调用jquery.cookie.js中的方法设置cookie中的登陆密码，并使用base64（jquery.base64.js）进行加密
            }else{
                $.cookie("login_code", null);
                $.cookie("pwd", null);
            }
        }

        //清除所有cookie函数
        function clearAllCookie() {
            var date=new Date();
            date.setTime(date.getTime()-10000);
            var keys=document.cookie.match(/[^ =;]+(?=\=)/g);
            console.log("需要删除的cookie名字："+keys);
            if (keys) {
                for (var i = keys.length; i--;)
                    document.cookie=keys[i]+"=0; expire="+date.toGMTString()+"; path=/";
            }
        }
        //获取cookie    
        function getCookie(){
            var loginCode = $.cookie("login_code"); //获取cookie中的用户名    
            var pwd = $.cookie("pwd"); //获取cookie中的登陆密码  
            console.log("获取cookie:账户："+loginCode);
            console.log("获取cookie:密码："+pwd);
            if (!loginCode||loginCode==0) {
                console.log("账户："+!loginCode);
                //alert("请输出内容！");
            }else{
                $("#username").val(loginCode);
            }
            if(!pwd||pwd==0){
                console.log("密码："+!pwd);
            }else{
                //密码存在的话把密码填充到密码文本框    
                //console.log("密码解密后："+$.base64.decode(pwd));
                $("#password").val($.base64.decode(pwd));
                //密码存在的话把“记住用户名和密码”复选框勾选住    
                $("[name='remember']").attr("checked","true");
            }

        }
        function login(){
            var userName = $('#username').val();
            console.log("用户名："+userName);
            if(userName == ''){
                alert("请输入用户名。");
                return;
            }
            var userPass =$('#password').val();
            console.log("密码："+userPass);
            if(userPass == ''){
                alert("请输入密码。");
                return;
            }
            //判断是否选中复选框，如果选中，添加cookie  
            var jizhupwd=$("input[type='checkbox']").is(':checked');
            console.log("是否记住密码："+jizhupwd);
            if(jizhupwd){
                //添加cookie    
                setCookie();
            }else{
                clearAllCookie();
            }
            netWorking(userName,userPass);//联网上传账号密码
        }
        function netWorking(zhanghao,mima){
            $.ajax({
                type:"post",
                url:loginurl,
                data:{
                    username:zhanghao,  //期刊id
                    password:mima,
                },
                success: function(res) {
                    console.log("请求数据1.："+res);
                    console.log("请求数据2.："+JSON.stringify(res));
                    var datas=eval(res);
                    var ticket=datas.ticket;
                    //var ticket=datas.msg;
                    console.log("请求数据2.："+ticket);
                    if (ticket==undefined) {
                        alert("请您先注册");
                    } else{
                        window.location.href='htmls/home.html';
                    }
                },
                error:function() {
                    alert("失败");
                }
            });
        }

    </script>
</head>
<body>
<div class="header">
    <div class="logo fl">
        <h1>
            <a href="index.jsp" title="拼优购">拼优购</a>
        </h1>
    </div>
</div>

<div class="login-main">
    <div class="w">
        <div class="loginfrom">
            <div class="a-from">
                <a href="#" class="from1 fl" id="login_type_QRcode_title">扫描登陆</a>
                <span class="spa">|</span>
                <a href="#" class="from2 fr" id="login_type_password_title">账户登陆</a>
            </div>
            <div class="anno">公共场所不建议自动登录，以免账号丢失</div>
            <div  id="login_type_password_form" class="login_type_password_form">
                <form action="${pageContext.request.contextPath}/loginServlet" method="post">
                    <div class="logininput">
                        <input type="text" name="username" id="username" class="user" placeholder="邮箱/用户名/手机号">
                        <i class="useri"></i>
                        <input type="password" name="password" id="password" class="password" placeholder="请输入密码">
                        <i class="passwordi"></i>
                    </div>
                    <div class="form-inline">
                        <label for="vcode">验证码：</label>
                        <input type="text" name="verifycode" class="vcode" id="verifycode" placeholder="请输入验证码" style="width: 120px; padding-left: 10px;"/>
                        <a href="javascript:refreshCode()">
                            <img src="${pageContext.request.contextPath}/checkCodeServlet" title="看不清点击刷新" id="vcode"/>
                        </a>
                    </div>
                    <div class="check">
                        <input type="checkbox" checked="checked" name="remember"><span>自动登录</span>
                        <a href="#">忘记密码?</a>
                    </div>
                    <div>
                        <button class="loginbtn" type="submit" value="登录">登&nbsp;&nbsp;&nbsp;录</button>
                    </div>
                </form>
            </div>
            <div id="login_type_QRcode_form" class="login_type_QRcode_form">
                <div >
                    <img src="img/qrcode.png" style="width: 250px; height: 240px; margin-left: 10px">
                </div>
            </div>

            <div class="link">
                <!--<ul>
                    <li class="denglu_qq"></li>
                    <li class="denglu_wb"></li>
                    <li class="denglu_zfb"></li>
                    <li class="denglu_wx"></li>
                </ul>-->
                <a href="https://graph.qq.com/oauth2.0/show?which=Login&display=pc&response_type=code&state=F6F9AF1409610415EF86F1E00DFAFC03B4346008A5B4F8D5EA3BB1A7B40ECAB70768BA81F55E4E995B71DA0A2FE931B1&client_id=100273020&redirect_uri=https%3A%2F%2Fqq.jd.com%2Fnew%2Fqq%2Fcallback.action%3Fview%3Dnull%26uuid%3D18d9c2e7c4684bb8a12a5912f4c9d7ae"><img src="images/regetype.png" alt="" class="qitadenglu"></a>
                <a href="register.jsp"><span>立即注册</span></a>
            </div>


        </div>
    </div>
</div>
<script>
    /*window.alert = function(name){
        var iframe = document.createElement("IFRAME");
        iframe.style.display="none";
        iframe.setAttribute("src", 'data:text/plain');
        document.documentElement.appendChild(iframe);
        window.frames[0].window.alert(name);
        iframe.parentNode.removeChild(iframe);
    }*/
    <c:if test="${login_msg!=null}">
    window.alert("${login_msg}");
    </c:if>
</script>


<%--<iframe src="bottom.jsp" width="100%" height="400" scrolling="no" frameborder="0"></iframe>--%>
<div id="shopping_foot"></div>
</body>
</html>
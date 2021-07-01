<%--
  Created by IntelliJ IDEA.
  User: 10796
  Date: 2021/1/21
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<header id="header">
    <hgroup>
        <h1 class="site_title" style="text-align: center"><a href="${pageContext.request.contextPath}/admin/home.jsp">管理项</a></h1>
        <h2 class="section_title">仪表盘</h2>
        <div class="btn_view_site"><a href="${pageContext.request.contextPath}/index.jsp">查看官网</a></div>
    </hgroup>
</header> <!-- end of header bar -->

<aside id="sidebar" class="column">
    <form class="quick_search">
        <input type="text" value="Quick Search" onfocus="if(!this._haschanged){this.value=''};this._haschanged=true;">
    </form>
    <hr/>
    <h3>分类管理</h3>
    <ul class="toggle">
        <li class="icn_categories"><a href="${pageContext.request.contextPath}/adminCategoryServlet">分类列表</a></li>
        <li class="icn_new_article"><a href="${pageContext.request.contextPath}/admin/category/add.jsp">添加分类</a></li>
    </ul>
    <h3>用户管理</h3>
    <ul class="toggle">
        <li class="icn_view_users"><a href="${pageContext.request.contextPath}/findUserByPageServlet">用户列表</a></li>
        <li class="icn_add_user"><a href="${pageContext.request.contextPath}/admin/user/add.jsp">新增用户</a></li>
        <li class="icn_profile"><a href="#">我的信息</a></li>
    </ul>
    <h3>商品管理</h3>
    <ul class="toggle">
        <li class="icn_folder"><a href="${pageContext.request.contextPath}/findAllServlet">商品列表</a></li>
        <li class="icn_new_article"><a href="${pageContext.request.contextPath}/addPUIServlet">添加商品</a></li>
    </ul>
    <h3>订单管理</h3>
    <ul class="toggle">
        <li class="icn_categories"><a href="${pageContext.request.contextPath}/findAllOrdServlet">订单列表</a></li>
        <li class="icn_photo"><a href="${pageContext.request.contextPath}/findAllOrdServlet?state=0">未付款订单</a></li>
        <li class="icn_photo"><a href="${pageContext.request.contextPath}/findAllOrdServlet?state=1">已付款订单</a></li>
        <li class="icn_photo"><a href="${pageContext.request.contextPath}/findAllOrdServlet?state=2">已发货订单</a></li>
        <li class="icn_photo"><a href="${pageContext.request.contextPath}/findAllOrdServlet?state=3">已完成订单</a></li>
    </ul>
    <h3>仓库异常管理</h3>
    <ul class="toggle">
        <li class="icn_categories"><a href="${pageContext.request.contextPath}/WareHouseServlet?method=abnormalList">异常列表</a></li>
        <li class="icn_photo"><a href="${pageContext.request.contextPath}/admin/abnormal/abnormal-chart.jsp">异常统计</a></li>


    </ul>
    <footer>
        <hr />
        <p><strong>拼优购电子商务平台后台管理</strong></p>
    </footer>
</aside><!-- end of sidebar -->
</body>
</html>

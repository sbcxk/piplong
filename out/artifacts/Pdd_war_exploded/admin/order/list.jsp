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
    <script src="../../js/hideshow.js" type="text/javascript"></script>
    <script src="../../js/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../js/jquery.equalHeight.js"></script>
    <script src="../../js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="../../layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
                $(".tablesorter").tablesorter();
            }
        );
        $(document).ready(function() {

            //When page loads...
            $(".tab_content").hide(); //Hide all content
            $("ul.tabs li:first").addClass("active").show(); //Activate first tab
            $(".tab_content:first").show(); //Show first tab content

            //On Click Event
            $("ul.tabs li").click(function() {

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
        $(function(){
            $('.column').equalHeight();
        });
    </script>
    <script type="text/javascript">
        function showDetail(oid){
            //alert(oid);
            //发送ajax
            $.post("${pageContext.request.contextPath}/showDetailServlet",{"method":"doPost","oid":oid},function(d){
                //alert(d);
                var s="<table border='1' width='99%'>";
                s+="<tr><th>商品名称</th><th>购买数量</th></tr>"

                $(d).each(function(){
                    s+="<tr><td>"+this.product.pname+"</td><td>"+this.count+"</td></tr>";
                });

                s+="</table>";

                layer.open({
                    type: 1,//0:信息框; 1:页面; 2:iframe层;	3:加载层;	4:tip层
                    title:"订单号:"+oid,//标题
                    area: ['520px', '300px'],//大小
                    shadeClose: true, //点击弹层外区域 遮罩关闭
                    content: s//内容
                });
            },"json");
        }
    </script>
    <script>
        function deleteOrder(oid) {
            //用户安全提示
            if (confirm("宁真的要把我删了吗QWQ？")) {
                //访问路径
                location.href = "${pageContext.request.contextPath}/delOrderServlet?oid=" + oid;
            }
        }
    </script>
</head>
<body>

<%@include file="../left.jsp"%>
<section id="main" class="column">

    <h4 class="alert_info">欢迎使用订单管理功能。</h4>
    <article class="module width_full">
        <header><h3>订单列表</h3></header>
            <table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
                <TBODY>
                <tr>
                    <td class="ta_01" align="center" bgColor="#f5fafe">
                        <table cellspacing="0" cellpadding="1" rules="all"
                               bordercolor="gray" border="1" id="DataGrid1"
                               style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
                            <tr
                                    style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

                                <td align="center" width="16%">
                                    序号
                                </td>
                                <td align="center" width="14%">
                                    订单编号
                                </td>
                                <td align="center" width="10%">
                                    订单金额
                                </td>
                                <td align="center" width="10%">
                                    收货人
                                </td>
                                <td align="center" width="6%">
                                    订单状态
                                </td>
                                <td align="center" width="10%">
                                    订单详情
                                </td>
                                <%--<td align="center" width="10%">
                                    订单操作
                                </td>--%>
                            </tr>
                            <c:forEach items="${sessionScope.list }" var="o" varStatus="vs">
                                <tr onmouseover="this.style.backgroundColor = 'white'"
                                    onmouseout="this.style.backgroundColor = '#F5FAFE';">
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="14%">
                                            ${vs.count }
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="21%">
                                            ${o.oid }
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="17%">
                                            ${o.total }
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="12%">
                                            ${o.name }
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="14%">
                                        <c:if test="${o.state == 0 }">未付款</c:if>
                                        <c:if test="${o.state == 1 }">
                                            <a href="${pageContext.request.contextPath }/updateStateServlet?method=doPost&oid=${o.oid}">去发货</a>
                                        </c:if>
                                        <c:if test="${o.state == 2 }">待收货</c:if>
                                        <c:if test="${o.state == 3 }">已完成</c:if>
                                    </td>
                                    <td align="center" style="HEIGHT: 22px">
                                        <input type="button" value="订单详情"  onclick="showDetail('${o.oid}')"/>
                                    </td>
                                    <%--<td align="center" style="HEIGHT: 22px" width="8%">
                                        <a href="${ pageContext.request.contextPath }/updateOrderServlet?pid=${o.oid}">
                                            <img src="${pageContext.request.contextPath}/images/icn_edit.png" width="16" height="16" border="0" style="CURSOR: hand">
                                        </a>
                                        <a href="${pageContext.request.contextPath}/delOrderServlet?oid=${o.oid}" >
                                            <img src="${pageContext.request.contextPath}/images/icn_trash.png" width="16" height="16" border="0" style="CURSOR: hand">
                                        </a>
                                    </td>--%>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </tr>
                </TBODY>
            </table>
    </article><!-- end of styles article -->
    <div class="spacer"></div>
</section>



</body>

</html>
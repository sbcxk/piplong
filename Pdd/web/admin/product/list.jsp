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

    <h4 class="alert_info">欢迎使用查询所有商品功能。</h4>
    <article class="module width_full">
        <header><h3>商品列表</h3></header>
            <table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
                <TBODY>

                <tr>
                    <td class="ta_01" align="center" bgColor="#f5fafe">
                        <table cellspacing="0" cellpadding="1" rules="all"
                               bordercolor="gray" border="1" id="DataGrid1"
                               style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
                            <tr
                                    style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

                                <td align="center" width="6%">
                                    序号
                                </td>
                                <td align="center" width="17%">
                                    商品图片
                                </td>
                                <td align="center" width="12%">
                                    商品名称
                                </td>
                                <td align="center" width="17%">
                                    商品标价
                                </td>
                                <td align="center" width="17%">
                                    商品售价
                                </td>
                                <td align="center" width="7%">
                                    是否热门
                                </td>
                                <td width="7%" align="center">
                                    是否下架
                                </td>
                                <td width="7%" align="center">
                                    编辑
                                </td>

                            </tr>

                            <c:forEach items="${sessionScope.list }" var="p" varStatus="vs">
                                <tr onmouseover="this.style.backgroundColor = 'white'"
                                    onmouseout="this.style.backgroundColor = '#F5FAFE';">
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="6%">
                                            ${vs.count }
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center" width="17%">
                                            <img src="../../goods/${p.pimages}" width="40" height="45" >
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="12%">
                                            ${p.pname }
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="17%">
                                            ${p.market_price }
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="17%">
                                            ${p.good_price }
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="7%">
                                        <c:if test="${p.is_hot==1 }">是</c:if>
                                        <c:if test="${p.is_hot!=1 }">否</c:if>
                                    </td>
                                    <td style="CURSOR: hand; HEIGHT: 22px" align="center"
                                        width="7%">
                                        <c:if test="${p.pflag==1 }">是</c:if>
                                        <c:if test="${p.pflag!=1 }">否</c:if>
                                    </td>
                                    <td align="center" style="HEIGHT: 22px">
                                        <a href="${ pageContext.request.contextPath }/findProductByPidServlet?pid=${p.pid}">
                                            <img src="${pageContext.request.contextPath}/images/icn_edit.png" border="0" style="CURSOR: hand">
                                        </a>
                                    </td>

                                    <%--<td align="center" style="HEIGHT: 22px">
                                        <a href="${ pageContext.request.contextPath }/delProductServlet?pid=${p.pid}">
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
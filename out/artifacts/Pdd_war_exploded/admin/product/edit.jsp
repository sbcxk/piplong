<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8"/>
    <title>商品管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="../../css/layout.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="../../css/ie.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="../../css/bootstrap.min.css" type="text/css" media="screen"/>
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

    <h4 class="alert_info">欢迎使用商品管理功能。</h4>
    <article class="module width_full">
        <header><h3>编辑商品</h3></header>
        <form action="${pageContext.request.contextPath}/updateProductServlet" method="post" enctype="multipart/form-data">
            <%--隐藏域 提交id--%>
            <input type="hidden" name="pid" value="${pd.pid}">
            <%--<div class="form-group">
                <label for="pname">商品名：</label>
                <input type="text" class="form-control" id="pname" name="pname"  value=${pd.pname} placeholder="请输商品名" />
            </div>

            <div class="form-group">
                <label for="market_price">商品标价：</label>
                <input type="text" class="form-control" id="market_price" value=${pd.market_price}  name="market_price" placeholder="请输入商品标价" />
            </div>

            <div class="form-group">
                <label for="good_price">商品售价：</label>
                <input type="text" id="good_price" class="form-control" name="good_price" value=${pd.good_price}  placeholder="请输入商品售价"/>
            </div>

            <div class="form-group">
                    <label for="is_hot">是否热门：</label>
                    <input type="text" id="is_hot" class="form-control" name="is_hot" value=${pd.is_hot}  placeholder="请输入是否热门"/>
            </div>
            <div class="form-group">
                <label for="is_hot">商品描述：</label>
                <input type="text" id="pdesc" class="form-control" name="pdesc" value=${pd.pdesc}  placeholder="请输入商品描述"/>
            </div>
            <div class="form-group">
                <label for="is_hot">是否下架：</label>
                <input type="text" id="pflag" class="form-control" name="pflag" value=${pd.pflag}  placeholder="请输入商品描述"/>
            </div>
            <div class="form-group">
                <label for="is_hot">：</label>
                <input type="text" id="pflag" class="form-control" name="pflag" value=${pd.pflag}  placeholder="请输入商品描述"/>
            </div>
            <div class="form-group" style="text-align: center">
                <input class="btn btn-primary" type="submit" value="提交" />
                <input class="btn btn-default" type="reset" value="重置" />
                <input class="btn btn-default" typeof="" type="button" value="返回"/>
            </div>--%>

                <table cellSpacing="1" cellPadding="5" width="100%" align="center" bacgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">

                    <tr>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            商品名称：
                        </td>
                        <td class="ta_01" bgColor="#ffffff">
                            <input type="text" name="pname" value="${pd.pname}" id="pname" class="bg" placeholder="请输商品名"/>
                        </td>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            是否热门：
                        </td>
                        <td class="ta_01" bgColor="#ffffff">
                            <select name="is_hot" id="is_hot" value="${pd.is_hot}">

                                <option value="1" <c:if test="${'1' eq pd.is_hot}">selected</c:if>>是</option>
                                <option value="0" <c:if test="${'0' eq pd.is_hot}">selected</c:if>>否</option>
                            </select>
                        </td>

                    </tr>
                    <tr>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            市场价格：
                        </td>
                        <td class="ta_01" bgColor="#ffffff">
                            <input type="text" name="market_price" value=${pd.market_price} id="market_price" class="bg" placeholder="请输入市场价格"/>
                        </td>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            商城价格：
                        </td>
                        <td class="ta_01" bgColor="#ffffff">
                            <input type="text" name="good_price" value=${pd.good_price}  placeholder="请输入商城售价" id="good_price" class="bg"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            商品图片：
                        </td>
                        <td class="ta_01" bgColor="#ffffff" >
                            <input type="file" name="pimages" id="pimages" >
                        (不选择保持原图片)
                        </td>

                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            是否下架：
                        </td>
                        <td class="ta_01" bgColor="#ffffff">
                            <select name="pflag" id="pflag" value="${pd.pflag}" >

                                <option value="1" <c:if test="${'1' eq pd.pflag}">selected</c:if>>是</option>
                                <option value="0" <c:if test="${'0' eq pd.pflag}">selected</c:if>>否</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
                            商品描述：
                        </td>
                        <td class="ta_01" bgColor="#ffffff" colspan="3">
                            <textarea name="pdesc" rows="5" cols="30" id="pdesc" placeholder="请输入商品描述" >${pd.pdesc}</textarea>
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
                            <INPUT class="button_ok" type="button" onclick="history.go(-1)" value="返回"/>
                            <span id="Label1"></span>
                        </td>
                    </tr>
                </table>
        </form>
    </article>


    <div class="spacer"></div>
</section>


</body>

</html>
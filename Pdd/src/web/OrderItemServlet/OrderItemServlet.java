package web.OrderItemServlet;


import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;
import constant.Constant;
import domain.CartItem;
import domain.Order;
import domain.OrderItem;
import domain.User;
import service.CartItemService;
import service.OrderService;
import service.impl.CartItemServiceImpl;
import service.impl.OrderServiceImpl;
import util.PaymentUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

@WebServlet("/OrderItemServlet")
public class OrderItemServlet extends BaseServlet {

    private OrderService orderService=new OrderServiceImpl();
    private CartItemService cartItemService = new CartItemServiceImpl();


    /*生成订单*/
    public void createOrder(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException {
        //设置编码
        req.setCharacterEncoding("utf-8");
        /*
         * 1. 获取所有购物车条目的id，查询之
         */
        String cartItemIds = req.getParameter("cartItemIds");
        List<CartItem> cartItemList = cartItemService.loadCartItems(cartItemIds);
        /*
         * 2. 创建Order
         */
        Order order = new Order();
        order.setOid(CommonUtils.uuid());//设置主键
        order.setOrdertime(new Date());//下单时间
        order.setState(Constant.order_weifukuan);//设置状态，未付款
        String address = new String(req.getParameter("address").getBytes("iso-8859-1"), "utf-8");
        String telephone = new String(req.getParameter("telephone").getBytes("iso-8859-1"), "utf-8");
        String name = new String(req.getParameter("name").getBytes("iso-8859-1"), "utf-8");

        System.out.println(address);
        System.out.println(telephone);
        System.out.println(name);

        order.setAddress(address);//设置收货地址
        order.setTelephone(telephone);//设置手机号
        order.setName(name);//设置收货人
        User owner = (User)req.getSession().getAttribute("user");
        order.setUser(owner);//设置订单所有者

        BigDecimal total = new BigDecimal("0");
        for(CartItem cartItem : cartItemList) {
            total = total.add(new BigDecimal(cartItem.getSubtotal() + ""));
        }
        order.setTotal(total.doubleValue());//设置总计

        /*
         * 3. 创建List<OrderItem>
         * 一个CartItem对应一个OrderItem
         */
        List<OrderItem> orderItemList = new ArrayList<OrderItem>();
        for(CartItem cartItem : cartItemList) {
            OrderItem orderItem = new OrderItem();
            orderItem.setItemid(CommonUtils.uuid());//设置主键
            orderItem.setCount(cartItem.getCount());
            orderItem.setSubtotal(cartItem.getSubtotal());
            orderItem.setProduct(cartItem.getProduct());
            orderItem.setOrder(order);
            orderItemList.add(orderItem);
        }
        order.setOrderItemList(orderItemList);

        /*
         * 4. 调用service完成添加
         */
        orderService.createOrder(order);

        // 删除购物车条目
        cartItemService.batchDelete(cartItemIds);
        /*
         * 5. 保存订单，转发到ordersucc.jsp
         */
        req.setAttribute("order", order);
        req.getRequestDispatcher(req.getContextPath()+"/order_ok.jsp").forward(req,resp);
    }

    /**
     * 加载订单
     */
    public void load(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException {
        String oid = req.getParameter("oid");
        Order order = orderService.load(oid);
        req.setAttribute("order", order);
        String btn = req.getParameter("btn");//btn说明了用户点击哪个超链接来访问本方法的
        req.setAttribute("btn", btn);
        req.getRequestDispatcher(req.getContextPath()+"/desc.jsp").forward(req,resp);
    }

    /**
     * 取消订单
     */
    public void cancel(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException {
        String oid = req.getParameter("oid");
        /*
         * 校验订单状态
         */
        int status = orderService.findStatus(oid);
        /*if(status != 1) {
            req.setAttribute("code", "error");
            req.setAttribute("msg", "状态不对，不能取消！");
            return "f:/jsps/msg.jsp";
        }*/
        orderService.updateStatus(oid, 5);//设置状态为取消！

        req.getRequestDispatcher(req.getContextPath()+"/findMyOrdersServlet?method=doPost&pageNumber=1").forward(req,resp);
    }

    /**
     * 确认收货
     */
    public void confirm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException {
        String oid = req.getParameter("oid");
        /*
         * 校验订单状态
         */
        int status = orderService.findStatus(oid);
        /*if(status != 3) {
            req.setAttribute("code", "error");
            req.setAttribute("msg", "状态不对，不能确认收货！");
            return "f:/jsps/msg.jsp";
        }*/
        orderService.updateStatus(oid, 3);//设置状态为交易成功！
        req.getRequestDispatcher(req.getContextPath()+"/findMyOrdersServlet?method=doPost&pageNumber=1").forward(req,resp);
    }

    public void paymentPre(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException {
        req.setAttribute("order", orderService.load(req.getParameter("oid")));
        req.getRequestDispatcher(req.getContextPath()+"/order_ok.jsp").forward(req,resp);
    }

    /**
     * 截取url，页面中的分页导航中需要使用它做为超链接的目标！
     * @param req
     * @return
     */
    /*
     * http://localhost:8080/goods/BookServlet?methed=findByCategory&cid=xxx&pc=3
     * /goods/BookServlet + methed=findByCategory&cid=xxx&pc=3
     */
    private String getUrl(HttpServletRequest req) {
        String url = req.getRequestURI() + "?" + req.getQueryString();
        /*
         * 如果url中存在pc参数，截取掉，如果不存在那就不用截取。
         */
        int index = url.lastIndexOf("&pc=");
        if(index != -1) {
            url = url.substring(0, index);
        }
        return url;
    }


    /**
     * 支付方法

     */
    public void payment(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Properties props = new Properties();
        props.load(this.getClass().getClassLoader().getResourceAsStream("payment.properties"));
        /*
         * 1. 准备13个参数
         */
        String p0_Cmd = "Buy";//业务类型，固定值Buy
        String p1_MerId = props.getProperty("p1_MerId");//商号编码，在易宝的唯一标识
        String p2_Order = req.getParameter("oid");//订单编码
        String p3_Amt = "0.01";//支付金额
        String p4_Cur = "CNY";//交易币种，固定值CNY
        String p5_Pid = "";//商品名称
        String p6_Pcat = "";//商品种类
        String p7_Pdesc = "";//商品描述
        String p8_Url = props.getProperty("p8_Url");//在支付成功后，易宝会访问这个地址。
        String p9_SAF = "0";//送货地址
        String pa_MP = "";//扩展信息
        String pd_FrpId = req.getParameter("yh");//支付通道
        //String pd_FrpId = "CCB-NET-B2C";//支付通道
        String pr_NeedResponse = "1";//应答机制，固定值1

        /*
         * 2. 计算hmac
         * 需要13个参数
         * 需要keyValue
         * 需要加密算法
         */
        String keyValue = props.getProperty("keyValue");
        String hmac = PaymentUtil.buildHmac(p0_Cmd, p1_MerId, p2_Order, p3_Amt,
                p4_Cur, p5_Pid, p6_Pcat, p7_Pdesc, p8_Url, p9_SAF, pa_MP,
                pd_FrpId, pr_NeedResponse, keyValue);

        /*
         * 3. 重定向到易宝的支付网关
         */
        StringBuffer sb = new StringBuffer("https://www.yeepay.com/app-merchant-proxy/node");
        sb.append("?").append("p0_Cmd=").append(p0_Cmd);
        sb.append("&").append("p1_MerId=").append(p1_MerId);
        sb.append("&").append("p2_Order=").append(p2_Order);
        sb.append("&").append("p3_Amt=").append(p3_Amt);
        sb.append("&").append("p4_Cur=").append(p4_Cur);
        sb.append("&").append("p5_Pid=").append(p5_Pid);
        sb.append("&").append("p6_Pcat=").append(p6_Pcat);
        sb.append("&").append("p7_Pdesc=").append(p7_Pdesc);
        sb.append("&").append("p8_Url=").append(p8_Url);
        sb.append("&").append("p9_SAF=").append(p9_SAF);
        sb.append("&").append("pa_MP=").append(pa_MP);
        sb.append("&").append("pd_FrpId=").append(pd_FrpId);
        sb.append("&").append("pr_NeedResponse=").append(pr_NeedResponse);
        sb.append("&").append("hmac=").append(hmac);

        resp.sendRedirect(sb.toString());

        //return null;
    }

    /**
     * 回馈方法
     * 当支付成功时，易宝会访问这里
     * 用两种方法访问：
     * 1. 引导用户的浏览器重定向(如果用户关闭了浏览器，就不能访问这里了)
     * 2. 易宝的服务器会使用点对点通讯的方法访问这个方法。（必须回馈success，不然易宝服务器会一直调用这个方法）
     */
    public String back(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException {
        /*
         * 1. 获取12个参数
         */
        String p1_MerId = req.getParameter("p1_MerId");
        String r0_Cmd = req.getParameter("r0_Cmd");
        String r1_Code = req.getParameter("r1_Code");
        String r2_TrxId = req.getParameter("r2_TrxId");
        String r3_Amt = req.getParameter("r3_Amt");
        String r4_Cur = req.getParameter("r4_Cur");
        String r5_Pid = req.getParameter("r5_Pid");
        String r6_Order = req.getParameter("r6_Order");
        String r7_Uid = req.getParameter("r7_Uid");
        String r8_MP = req.getParameter("r8_MP");
        String r9_BType = req.getParameter("r9_BType");
        String hmac = req.getParameter("hmac");
        /*
         * 2. 获取keyValue
         */
        Properties props = new Properties();
        props.load(this.getClass().getClassLoader().getResourceAsStream("payment.properties"));
        String keyValue = props.getProperty("keyValue");
        /*
         * 3. 调用PaymentUtil的校验方法来校验调用者的身份
         *   >如果校验失败：保存错误信息，转发到msg.jsp
         *   >如果校验通过：
         *     * 判断访问的方法是重定向还是点对点，如果要是重定向
         *     修改订单状态，保存成功信息，转发到msg.jsp
         *     * 如果是点对点：修改订单状态，返回success
         */
        boolean bool = PaymentUtil.verifyCallback(hmac, p1_MerId, r0_Cmd, r1_Code, r2_TrxId,
                r3_Amt, r4_Cur, r5_Pid, r6_Order, r7_Uid, r8_MP, r9_BType,
                keyValue);
        if(!bool) {
            req.setAttribute("code", "error");
            req.setAttribute("msg", "无效的签名，支付失败！（你不是好人）");
            return "f:/jsps/msg.jsp";
        }
        if(r1_Code.equals("1")) {
            orderService.updateStatus(r6_Order, 2);
            if(r9_BType.equals("1")) {
                req.setAttribute("code", "success");
                req.setAttribute("msg", "恭喜，支付成功！");
                return "f:/jsps/msg.jsp";
            } else if(r9_BType.equals("2")) {
                resp.getWriter().print("success");
            }
        }
        return null;
    }
}

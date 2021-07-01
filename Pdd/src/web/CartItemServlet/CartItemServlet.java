package web.CartItemServlet;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;
import domain.CartItem;
import domain.Product;
import domain.User;
import service.CartItemService;
import service.impl.CartItemServiceImpl;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/CartItemServlet")
public class CartItemServlet extends BaseServlet {

    private CartItemService cartItemService = new CartItemServiceImpl();

    /**
     * 我的购物车
     */
    public void myCart(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            System.out.println("没有登陆");
            req.setAttribute("wdl", "请先登录");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        int uid = user.getId();
        //获取购物车条目
        CartItemService cartItemService = new CartItemServiceImpl();
        List<CartItem> cartItemList = null;
        try {
            cartItemList = cartItemService.myCart(uid);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        HttpSession session = req.getSession();
        session.setAttribute("cartItemList", cartItemList);
        //request.getRequestDispatcher("/admin/product/list.jsp").forward(request,response);
        resp.sendRedirect(req.getContextPath() + "/cart.jsp");

    }

    /**
     * 加入购物车
     */
    public void add(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        /*封装表单数据*/
        Map map = req.getParameterMap();
        CartItem cartItem = CommonUtils.toBean(map, CartItem.class);
        Product product = CommonUtils.toBean(map, Product.class);
        User user = (User) req.getSession().getAttribute("user");
        cartItem.setUser(user);
        cartItem.setProduct(product);
        /*调用service完成查询*/
        cartItemService.add(cartItem);

        /*加入完毕，跳转至购物车*/
        myCart(req, resp);
    }

    /**
     * 批量删除
     */
    public void batchDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        String cartItemsIds = req.getParameter("cartItemIds");
        cartItemService.batchDelete(cartItemsIds);
        /*删除完毕，跳转至购物车*/
        myCart(req, resp);
    }

    /**
     * 修改数量
     */
    public void updateCount(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        String cartItemId = req.getParameter("cartItemId");
        int count = Integer.parseInt(req.getParameter("count"));
        CartItem cartItem = cartItemService.updateCount(cartItemId, count);

        // 给客户端返回一个json对象
        StringBuilder sb = new StringBuilder("{");
        sb.append("\"count\"").append(":").append(cartItem.getCount());
        sb.append(",");
        sb.append("\"subtotal\"").append(":").append(cartItem.getSubtotal());
        sb.append("}");
        //System.out.println(sb);
        resp.getWriter().print(sb);
        //myCart(req, resp);
    }

    /**
     * 加载多个CartItem
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public void loadCartItems(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException {
        /*
         * 1. 获取cartItemIds参数
         */
        String cartItemIds = req.getParameter("cartItemIds");
        double total = Double.parseDouble(req.getParameter("total"));
        /*
         * 2. 通过service得到List<CartItem>
         */
        List<CartItem> cartItemList = cartItemService.loadCartItems(cartItemIds);
        /*
         * 3. 保存，然后转发到/cart/showitem.jsp
         */
        req.setAttribute("cartItemList", cartItemList);
        req.setAttribute("total", total);
        req.setAttribute("cartItemIds", cartItemIds);
        req.getRequestDispatcher(req.getContextPath()+"/showitem.jsp").forward(req,resp);
        //resp.sendRedirect(req.getContextPath()+"/showitem.jsp");
    }


}

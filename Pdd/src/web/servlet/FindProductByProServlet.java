package web.servlet;

import domain.Product;
import domain.User;
import service.ProductService;
import service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/findProductByProServlet")
public class FindProductByProServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        //调用service查询
        String product=request.getParameter("product");
        System.out.println(product);
        ProductService service=new ProductServiceImpl();
        List<Product> list=service.findProductByName(product);

        //2.将返回值放入request中,请求转发
        /*HttpSession session = request.getSession();
        session.setAttribute("list",list);
        //request.getRequestDispatcher("/admin/product/list.jsp").forward(request,response);
        response.sendRedirect("/Pdd/admin/user/list.jsp");*/
        request.setAttribute("list",list);

        request.getRequestDispatcher("cates.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}

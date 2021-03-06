package web.categoryServlet;

import domain.Category;
import domain.Product;
import service.CategoryService;
import service.impl.CategoryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
/**
 * 购物车分页
 * @author PPL
 *
 */
@WebServlet("/categoryPageServlet")
public class CategoryPageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        request.setCharacterEncoding("utf-8");
        String cid=request.getParameter("cid");

        CategoryService cs=new CategoryServiceImpl();

        List<Product>  list=cs.findByCid(cid);

        // request.setAttribute("list",list);
        //
        // request.getRequestDispatcher("cates.jsp").forward(request,response);
        //重定向
        HttpSession session = request.getSession();
        session.setAttribute("list",list);
        response.sendRedirect(request.getContextPath()+"/cates.jsp");

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        this.doPost(request, response);
    }
}

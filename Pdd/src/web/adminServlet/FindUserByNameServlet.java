package web.adminServlet;

import domain.PageBean;
import domain.User;
import service.ProductService;
import service.UserService;
import service.impl.ProductServiceImpl;
import service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 通过用户名查询用户
 * @author PPL
 *
 */
@WebServlet("/findUserByNameServlet")
public class FindUserByNameServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        //调用service查询
        String name=request.getParameter("name");
        System.out.println(name);
        UserService service = new UserServiceImpl();
        List<User> list=service.findUserByName(name);



        //2.将返回值放入request中,请求转发
        HttpSession session = request.getSession();
        session.setAttribute("list",list);
        //request.getRequestDispatcher("/admin/product/list.jsp").forward(request,response);
        response.sendRedirect(request.getContextPath()+"/admin/user/list.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}

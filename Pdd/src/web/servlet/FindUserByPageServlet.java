package web.servlet;

import domain.PageBean;
import domain.User;
import service.UserService;
import service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
/**
 * 分页查找用户
 * @author PPL
 *
 */
@WebServlet("/findUserByPageServlet")
public class FindUserByPageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        //获取参数
        String currentPage = request.getParameter("currentPage");//当前页码、
        String rows = request.getParameter("rows");//每页显示条数
        String totalPage=request.getParameter("totalPage");
        if (currentPage == null || "".equals(currentPage)) {
            currentPage = "1";
        }
        // else if (Integer.parseInt(currentPage) >=Integer.parseInt(totalPage)) {
        //     currentPage = totalPage;
        // }
        if (rows == null || "".equals(rows)) {
            rows = "5";
        }

        //获取条件查询参数
        Map<String, String[]> condition = request.getParameterMap();

        //调用service查询
        UserService service = new UserServiceImpl();
        //PageBean pb=service.findUserByPage(currentPage,rows);
        PageBean<User> pb = service.findUserByPage(currentPage, rows, condition);

        //将PageBean存入request
        //request.setAttribute("pb", pb);
        //将查询条件存入request
        //request.setAttribute("condition",condition);
        //转发到list.jsp
        //request.getRequestDispatcher("/admin/user/list.jsp").forward(request, response);
        //response.sendRedirect(request.getContextPath()+"/admin/user/list.jsp");
        HttpSession session = request.getSession();
        session.setAttribute("pb",pb);
        session.setAttribute("condition",condition);
        //response.sendRedirect(request.getContextPath()+"/admin/user/list.jsp");
        request.getServletContext().getRequestDispatcher("/admin/user/list.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}

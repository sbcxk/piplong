package web.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import domain.User;
import service.UserService;
import service.impl.UserServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/findHaveUserServlet")
public class FindHaveUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置编码
        response.setContentType("text/html;charset=utf-8");

        //设置响应为json
        //response.setContentType("application/json;charset=utf-8");
        //获取用户名
        String username = request.getParameter("username");
        //调用service判断用户是否存在

        /*期待服务器响应的数据格式
          {"userExsit":true,"msg":"此用户名太受欢迎，请换一个"}
          {"userExsit":false,"msg":"用户名可用"}
         */

        Map<String,Object> map=new HashMap<>();
        //调用service方法
        UserService service=new UserServiceImpl();
        boolean isHad=service.findHaveUserServlet(username);
        if(isHad){
            map.put("userExsit",true);
            map.put("msg","用户名已被占用");
        }else {
            map.put("userExsit",false);
            map.put("msg","用户名可用");
        }

        //map转json
        ObjectMapper mapper=new ObjectMapper();
        //传递给客户端
        mapper.writeValue(response.getWriter(),map);
    }
}

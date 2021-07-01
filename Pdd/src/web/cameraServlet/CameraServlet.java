package web.cameraServlet;


import cn.itcast.servlet.BaseServlet;
import domain.InlineResource;
import domain.WareHouse;
import service.WareHouseService;
import service.impl.WareHouseServiceImpl;
import util.MailUtils;
import util.UuidUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/CameraServlet")
public class CameraServlet extends BaseServlet {
    public void start(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        System.out.println("开启监控线程");
        try {
            ImageServer01.ss = new ServerSocket(9000);
            new Thread(new ImageServer01()).start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void stop(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        System.out.println("关闭监控线程");
        ImageServer01.ss.close();
        WareHouseService wh =new WareHouseServiceImpl();
        String newImg=wh.findNewImg();
        //发送邮箱
        //String content="【优购商城】您的仓库异常检测已被关闭，请确认操作安全！";
        //String content="<a href='"+"http://119.23.254.93:8080"+"/activeUserServlet?code="+registUser.getCode()+"'>→_→点击激活【优购商城】</a>";
        MailUtils.sendMail("1079654850@qq.com",newImg,"优购仓库异常监测关闭提醒！");
    }
}
class ImageServer01 implements Runnable {

    private static final long serialVersionUID = 2839564863495205814L;

    public static ServerSocket ss;

    public ImageServer01() throws Exception {
        //监听端口

        new Thread(this).start();
    }

    @Override
    public void run() {
        int i = 0;
        System.out.println("server startup.");
        while (true) {
            try {
                Socket s = ss.accept();
                System.out.println(ss);
                // 每个客户端一个处理线程
                new Handler(s, i).start();
                i++;
            } catch (IOException e) {
                // e.printStackTrace();
                return ;
            }
        }
    }
}

class Handler extends Thread {
    Socket s;
    int id;

    public Handler(Socket s, int id) {
        this.s = s;
        this.id = id;
    }

    @Override
    public void run() {
        System.out.println("in handling..");

        FileOutputStream fos = null;
        InputStream is = null;
        try {

            is = s.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(is));
            String filename = System.currentTimeMillis() + ".jpg";
            //String filepath = "D:/Software/IdeaProjects/PPL/Pdd/web/imgRaspberry/";
            //String filepath = "D:/Software/IdeaProjects/PPL/out/artifacts/Pdd_war_exploded/imgRaspberry/";

            String realpath1 = this.getClass().getResource("").getPath();

            String realpath2=realpath1.substring(0,realpath1.indexOf("WEB-INF"))+"imgRaspberry/";
            String filepath=realpath2.substring(1);

            System.out.println("filepath:"+filepath);
            //System.out.println("realpath:"+realpath3);

            File dirFile = new File(filepath);
            if (!dirFile.exists()) {
                System.out.println("创建文件夹中");
                dirFile.mkdirs();
            }

            System.out.println("read line " + id + " :" + filename);
            File file = new File(filepath + filename);
            System.out.println("路径："+filepath + filename);
            int len = 0;
            int BUFSIZE = 1 * 1024;

            byte[] bytes = new byte[BUFSIZE];

            fos = new FileOutputStream(file);
            while ((len = is.read(bytes, 0, bytes.length)) != -1) {
                fos.write(bytes, 0, len);
                fos.flush();
            }
            System.out.println("done.");
            // FileInputStream fs = new FileInputStream(filepath + filename);
            //存入数据库
            WareHouse wh=new WareHouse();
            wh.setWid(UuidUtil.getUuid());
            wh.setStatus(0);
            wh.setWimage(filename);
            wh.setWdate(new Date());

            //保存
            WareHouseService whService=new WareHouseServiceImpl();
            whService.addAbnormal(wh);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 服务端就不要手贱 关了socket否则Python 会出现错误Errno 10054让客户端关掉就行啦
            try {
                System.out.println("close");
                fos.close();
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}


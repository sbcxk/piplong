/*
package web.filter;


import constant.Constant;
import domain.WareHouse;
import service.WareHouseService;
import service.impl.WareHouseServiceImpl;
import util.UuidUtil;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Date;

public class MyListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("开启监控线程");
        try {
            new Thread(new ImageServer01()).start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

}

class ImageServer01 implements Runnable {

    private static final long serialVersionUID = 2839564863495205814L;

    ServerSocket ss;

    public ImageServer01() throws Exception {
        //监听端口
        ss = new ServerSocket(9000);
        new Thread(this).start();
    }

    @Override
    public void run() {
        int i = 0;
        System.out.println("server startup.");
        while (true) {
            try {
                Socket s = ss.accept();
                // 每个客户端一个处理线程
                new Handler(s, i).start();
                i++;
            } catch (IOException e) {
                e.printStackTrace();
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

            //System.out.println("filepath:"+filepath);
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





*/

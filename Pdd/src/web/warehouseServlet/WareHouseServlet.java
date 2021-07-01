package web.warehouseServlet;

import cn.itcast.servlet.BaseServlet;
import com.arcsoft.face.*;
import com.arcsoft.face.enums.DetectMode;
import com.arcsoft.face.enums.DetectOrient;
import com.arcsoft.face.enums.ErrorInfo;
import com.arcsoft.face.enums.ImageFormat;
import com.arcsoft.face.toolkit.ImageInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import domain.Chart;
import domain.Face;
import domain.PageBean;
import domain.WareHouse;
import net.sf.json.JSONArray;
import service.WareHouseService;
import service.impl.WareHouseServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.arcsoft.face.toolkit.ImageFactory.getRGBData;

@WebServlet("/WareHouseServlet")
public class WareHouseServlet extends BaseServlet {
    private WareHouseService wareHouseService = new WareHouseServiceImpl();

    /**
     * 我的仓库异常 分页
     */
    public void abnormalList(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("utf-8");
        //获取参数
        String currentPage = req.getParameter("currentPage");//当前页码、
        String rows = req.getParameter("rows");//每页显示条数
        String totalPage = req.getParameter("totalPage");
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
        Map<String, String[]> condition = req.getParameterMap();
        PageBean<WareHouse> abnormalList = wareHouseService.findAllAbnormal(currentPage, rows, condition);
        HttpSession session = req.getSession();
        //将查询条件存入request
        session.setAttribute("condition", condition);
        session.setAttribute("abnormalList", abnormalList);
        //req.setAttribute("abnormalList",abnormalList);
        req.getServletContext().getRequestDispatcher("/admin/abnormal/abnormal-list.jsp").forward(req, resp);
        //resp.sendRedirect(req.getContextPath() + "/admin/abnormal/abnormal-list.jsp");
    }

    /**
     * 通过异常状态查找仓库异常事件
     */
    public void findAbnormalByStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        //获取status
        String status = req.getParameter("status");
        List<WareHouse> abnormalStatusList = wareHouseService.findAbnormalByStatus(status);
        HttpSession session = req.getSession();
        session.setAttribute("asList", abnormalStatusList);
        resp.sendRedirect(req.getContextPath() + "/admin/abnormal/abnormal-list.jsp");
    }

    /**
     * 通过id修改仓库异常事件
     */
    public void updateAbnormalById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("utf-8");
        //获取参数
        String wid = req.getParameter("wid");
        wareHouseService.updateAbnormal(wid);
        resp.sendRedirect(req.getContextPath() + "/WareHouseServlet?method=abnormalList");
    }

    /**
     * 通过id删除仓库异常事件
     */
    public void delAbnormalById(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("utf-8");
        //获取参数
        String wid = req.getParameter("wid");
        wareHouseService.delAbnormal(wid);
        resp.sendRedirect(req.getContextPath() + "/WareHouseServlet?method=abnormalList");

    }

    /**
     * 异常柱状图展示
     */
    public void findDate1(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("utf-8");

        int day = Integer.parseInt(req.getParameter("day"));
        // System.out.println("day:"+day);
        int days = day;


        List<Chart> list = new ArrayList<Chart>();
        //List<Integer> num = new ArrayList<Integer>();
        ArrayList<String> date = getDays(days);
        //System.out.println(wareHouseService.findAllAbnormalByDate(date.get(3)));
        for (int i = 0; i < date.size(); i++) {
            //num.add();
            //System.out.println("日期："+date.get(i)+"---数量："+num.get(i));
            list.add(new Chart(date.get(i), wareHouseService.findAllAbnormalByDate(date.get(i))));
        }
        /*list.add(new Chart("2021-6-25", 10));
        list.add(new Chart("2021-6-26", 20));
        list.add(new Chart("2021-6-27", 30));*/

        ObjectMapper mapper = new ObjectMapper();    //提供java-json相互转换功能的类

        String json = mapper.writeValueAsString(list);    //将list中的对象转换为Json格式的数组

        //System.out.println(json);

        //将json数据返回给客户端
        resp.setContentType("text/html; charset=utf-8");
        resp.getWriter().write(json);

    }

    /**
     * 获取过去7天内的日期数组
     */
    public ArrayList<String> getDays(int intervals) {
        ArrayList<String> pastDaysList = new ArrayList<>();
        for (int i = intervals - 1; i >= 0; i--) {
            pastDaysList.add(getPastDate(i));
        }
        return pastDaysList;
    }

    /**
     * 获取过去第几天的日期
     */
    public String getPastDate(int past) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);
        Date today = calendar.getTime();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String result = format.format(today);
        return result;
    }

    /**
     * 状态饼状图展示
     */
    public void findDate2(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("utf-8");
        int day = Integer.parseInt(req.getParameter("day"));
        // System.out.println("day:"+day);
        List<Chart> list = new ArrayList<Chart>();
        int days = day;
        int processed = 0, pending = 0;
        ArrayList<String> date = getDays(days);
        //System.out.println(wareHouseService.findAllAbnormalByDate(date.get(3)));
        for (int i = 0; i < date.size(); i++) {
            processed += wareHouseService.findProAbnormalByDate(date.get(i));
            pending += wareHouseService.findPenAbnormalByDate(date.get(i));
        }
        list.add(new Chart("已处理异常", processed));
        list.add(new Chart("待处理异常", pending));

        ObjectMapper mapper = new ObjectMapper();    //提供java-json相互转换功能的类

        String json = mapper.writeValueAsString(list);    //将list中的对象转换为Json格式的数组

        //System.out.println(json);

        //将json数据返回给客户端
        resp.setContentType("text/html; charset=utf-8");
        resp.getWriter().write(json);

    }

    /**
     * 人脸识别匹配
     */
    public void faceRec(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        System.out.println("进入人脸识别");
        String appId = "Fu5ZU68JRMK6CS8aJHoWNy58zvoqJghqRBqTfCTNysAD";
        String sdkKey = "9KJ79pL8qs9ad7nsaKBE7easbnTCgftW1BaJRjGMozgz";

        FaceEngine faceEngine = new FaceEngine("D:\\Software\\IdeaProjects\\PPL\\Pdd\\web\\WEB-INF\\lib\\WIN64");
        //激活引擎3
        int activeCode = faceEngine.activeOnline(appId, sdkKey);

        if (activeCode != ErrorInfo.MOK.getValue() && activeCode != ErrorInfo.MERR_ASF_ALREADY_ACTIVATED.getValue()) {
            System.out.println("引擎激活失败");
        }

        //引擎配置
        EngineConfiguration engineConfiguration = new EngineConfiguration();
        engineConfiguration.setDetectMode(DetectMode.ASF_DETECT_MODE_IMAGE);
        engineConfiguration.setDetectFaceOrientPriority(DetectOrient.ASF_OP_0_ONLY);

        //功能配置
        FunctionConfiguration functionConfiguration = new FunctionConfiguration();
        functionConfiguration.setSupportAge(true);
        functionConfiguration.setSupportFace3dAngle(true);
        functionConfiguration.setSupportFaceDetect(true);
        functionConfiguration.setSupportFaceRecognition(true);
        functionConfiguration.setSupportGender(true);
        functionConfiguration.setSupportLiveness(true);
        functionConfiguration.setSupportIRLiveness(true);
        engineConfiguration.setFunctionConfiguration(functionConfiguration);

        //初始化引擎
        int initCode = faceEngine.init(engineConfiguration);

        if (initCode != ErrorInfo.MOK.getValue()) {
            System.out.println("初始化引擎失败");
        }

        //获取前端选定的树莓派图库图片 faceImg1
        String faceImg1 = "D:\\Software\\IdeaProjects\\PPL\\out\\artifacts\\Pdd_war_exploded\\imgRaspberry\\" + req.getParameter("faceImg");

        //人脸检测
        ImageInfo imageInfo = getRGBData(new File(faceImg1));
        List<FaceInfo> faceInfoList = new ArrayList<FaceInfo>();
        int detectCode = faceEngine.detectFaces(imageInfo.getImageData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList);
        System.out.println(faceInfoList);

        //特征提取
        FaceFeature faceFeature = new FaceFeature();
        int extractCode = faceEngine.extractFaceFeature(imageInfo.getImageData(), imageInfo.getWidth(), imageInfo.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList.get(0), faceFeature);
        System.out.println("特征值大小：" + faceFeature.getFeatureData().length);

        // 循环从数据库获取已知人脸信息 直到相似度大于0.8
        //0.构建未找到时的人脸实体类
        Face noFindFace = new Face();
        noFindFace.setFace_id(-1);
        noFindFace.setFace_name("未知");
        noFindFace.setFace_post("未知");
        noFindFace.setFace_img("https://ww1.sinaimg.cn/large/007rAy9hgy1g24by9t530j30i20i2glm.jpg");
        noFindFace.setFace_age(-1);
        noFindFace.setFace_sex("未知");
        //是否找到人脸
        //int flag=0;

        //1.获取数据库人脸信息数据
        WareHouseService whService = new WareHouseServiceImpl();

        List<Face> faceList = whService.findCountFace();
        Float faceS = 0F;
        //2.循环比较
        for (int i = 0; i < faceList.size(); i++) {
            String faceName = faceList.get(i).getFace_img();
            String faceImg2 = "D:\\Software\\IdeaProjects\\PPL\\Pdd\\web\\imgFace\\" + faceName;

            //人脸检测2
            ImageInfo imageInfo2 = getRGBData(new File(faceImg2));
            List<FaceInfo> faceInfoList2 = new ArrayList<FaceInfo>();
            int detectCode2 = faceEngine.detectFaces(imageInfo2.getImageData(), imageInfo2.getWidth(), imageInfo2.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList2);
            System.out.println(faceInfoList);

            //特征提取2
            FaceFeature faceFeature2 = new FaceFeature();
            int extractCode2 = faceEngine.extractFaceFeature(imageInfo2.getImageData(), imageInfo2.getWidth(), imageInfo2.getHeight(), ImageFormat.CP_PAF_BGR24, faceInfoList2.get(0), faceFeature2);
            System.out.println("特征值大小：" + faceFeature.getFeatureData().length);

            //特征比对
            FaceFeature targetFaceFeature = new FaceFeature();
            targetFaceFeature.setFeatureData(faceFeature.getFeatureData());
            FaceFeature sourceFaceFeature = new FaceFeature();
            sourceFaceFeature.setFeatureData(faceFeature2.getFeatureData());
            FaceSimilar faceSimilar = new FaceSimilar();
            int compareCode = faceEngine.compareFaceFeature(targetFaceFeature, sourceFaceFeature, faceSimilar);
            Float faceSimilars = faceSimilar.getScore();
            //System.out.println("相似度：" + faceSimilars);

            if (faceSimilars >= 0.5) {
                //找到人脸 替换
                BigDecimal b = new BigDecimal(faceSimilars);
                float f1 = b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();

                noFindFace = faceList.get(i);
                noFindFace.setFace_name(noFindFace.getFace_name() + "(相似度：" + f1 + ")");
                break;
            }
        }
        System.out.println("人脸识别结束");
        System.out.println(noFindFace.toString());
        if (noFindFace.getFace_age() > 0)
            noFindFace.setFace_img("../imgFace/" + noFindFace.getFace_img());
        //System.out.println(JSONArray.fromObject(noFindFace));
        resp.getWriter().println(JSONArray.fromObject(noFindFace));

        //引擎卸载
        int unInitCode = faceEngine.unInit();

    }
}

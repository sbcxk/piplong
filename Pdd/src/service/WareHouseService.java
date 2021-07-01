package service;

import domain.Face;
import domain.PageBean;
import domain.WareHouse;

import java.util.List;
import java.util.Map;

public interface WareHouseService {
    //查找仓库所有异常
    PageBean<WareHouse> findAllAbnormal(String currentPage, String rows, Map<String, String[]> condition);

    //通过Status查找仓库异常
    List<WareHouse> findAbnormalByStatus(String status);

    //新建异常
    void addAbnormal(WareHouse wh);

    //删除异常
    void delAbnormal(String wid);

    //改变异常
    void updateAbnormal(String wid);
    //通过日期查询当天异常
    Integer findAllAbnormalByDate(String s);

    /**
     * 查找已处理异常数
     * @param s
     * @return
     */
    int findProAbnormalByDate(String s);

    /**
     * 查找未处理异常数
     * @param s
     * @return
     */
    int findPenAbnormalByDate(String s);

    //查找最新图片
    String findNewImg();

    /**
     * 查找已知人脸数据数量
     * @return
     */
    List<Face> findCountFace();
}

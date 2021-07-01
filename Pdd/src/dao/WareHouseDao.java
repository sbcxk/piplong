package dao;

import domain.Face;
import domain.WareHouse;

import java.util.List;
import java.util.Map;

public interface WareHouseDao {

    //查找所有异常
    List<WareHouse> findAllAbnormal(int start, int rows, Map<String, String[]> condition);

    //通过Status查找所有异常
    List<WareHouse> findAbnormalByStatus(String status);

    int findTotalCount(Map<String, String[]> condition);


    void addAbnormal(WareHouse wh);

    //删除异常
    void delAbnormal(String wid);
    //改变异常
    void updateAbnormal(String wid);

    //通过日期获取异常数
    Integer findAllAbnormalByDate(String date);

    /**
     * 查找已处理异常数
     * @param date
     * @return
     */
    int findProAbnormalByDate(String date);

    /**
     * 查找未处理异常数
     * @param date
     * @return
     */
    int findPenAbnormalByDate(String date);

    /**
     * 查找最新图片
     * @return
     */
    String findNewImg();

    /**
     * 查找已有人脸数据
     * @return
     */
    List<Face> findCountFace();
}

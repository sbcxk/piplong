package service.impl;

import dao.WareHouseDao;
import dao.impl.WareHouseDaoImpl;
import domain.Face;
import domain.PageBean;
import domain.WareHouse;
import service.WareHouseService;

import java.util.List;
import java.util.Map;

public class WareHouseServiceImpl implements WareHouseService {
    private final WareHouseDao wareHouseDao=new WareHouseDaoImpl();
    @Override
    public PageBean<WareHouse> findAllAbnormal(String _currentPage, String _rows, Map<String, String[]> condition) {
        int currentPage = Integer.parseInt(_currentPage);
        int rows = Integer.parseInt(_rows);

        if (currentPage <= 1) {
            currentPage = 1;
        }

        //创建空的PageBean对象
        PageBean<WareHouse> pb = new PageBean<WareHouse>();

        //设置参数
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        //调用dao查询总记录数
        int totalCount = wareHouseDao.findTotalCount(condition);
        pb.setTotalCount(totalCount);

        //调用dao查询List集合
        //计算开始索引
        int start = (currentPage - 1) * rows;
        List<WareHouse> list = wareHouseDao.findAllAbnormal(start, rows,condition);
        pb.setList(list);

        //计算总页码
        int totalPage = (totalCount % rows) == 0 ? totalCount / rows : (totalCount / rows) + 1;
        pb.setTotalPage(totalPage);

        if (currentPage >=totalPage) {
            currentPage = totalPage;
            //设置参数
            pb.setCurrentPage(currentPage);
            pb.setRows(rows);
            //计算开始索引
            start = (currentPage - 1) * rows;
            list = wareHouseDao.findAllAbnormal(start, rows,condition);
            pb.setList(list);
        }
        return pb;
        //return wareHouseDao.findAllAbnormal(currentPage,rows,condition);
    }

    @Override
    public List<WareHouse> findAbnormalByStatus(String status) {
        return wareHouseDao.findAbnormalByStatus(status);
    }

    @Override
    public void addAbnormal(WareHouse wh) {
        wareHouseDao.addAbnormal(wh);
    }

    @Override
    public void delAbnormal(String wid) {
        wareHouseDao.delAbnormal(wid);
    }

    @Override
    public void updateAbnormal(String wid) {
        wareHouseDao.updateAbnormal(wid);
    }

    @Override
    public Integer findAllAbnormalByDate(String date) {
        return wareHouseDao.findAllAbnormalByDate(date);
    }

    @Override
    public int findProAbnormalByDate(String date) {
        return wareHouseDao.findProAbnormalByDate(date);
    }

    @Override
    public int findPenAbnormalByDate(String date) {
        return wareHouseDao.findPenAbnormalByDate(date);
    }

    @Override
    public String findNewImg() {
        return wareHouseDao.findNewImg();
    }

    @Override
    public List<Face> findCountFace() {
        return wareHouseDao.findCountFace();
    }
}

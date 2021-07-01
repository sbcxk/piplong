package dao.impl;

import dao.WareHouseDao;

import domain.Face;
import domain.WareHouse;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class WareHouseDaoImpl implements WareHouseDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public List<WareHouse> findAllAbnormal(int start, int rows, Map<String, String[]> condition) {
        String sql = "select * from warehouse where 1 = 1 ";

        StringBuilder sb = new StringBuilder(sql);
        //遍历map
        Set<String> keySet = condition.keySet();
        //定义参数集合
        List<Object> params=new ArrayList<Object>();
        for (String key : keySet) {
            if("currentPage".equals(key)||"rows".equals(key)||"method".equals(key)){
                continue;
            }
            //获取value
            String value = condition.get(key)[0];
            //判断value是否有值
            if (value != null && !"".equals(value)) {
                sb.append(" and " + key + " like ? ");
                params.add("%"+value+"%");//?条件的值
            }
        }
        //添加分页
        sb.append(" order by wdate desc limit ? , ? ");
        //添加分页查询参数
        params.add(start);
        params.add(rows);

        sql=sb.toString();
        List<WareHouse> whList=null;
        //sql+=" order by wdate desc ";
        //System.out.println(sql);
        //System.out.println(params);
        try {
            return template.query(sql, new BeanPropertyRowMapper<WareHouse>(WareHouse.class),params.toArray());
        }catch (Exception e){

        }
        return whList;
        /*String sql = "select * from warehouse by wdate desc";
        List<WareHouse> wareList=template.query(sql, new BeanPropertyRowMapper<WareHouse>(WareHouse.class));
        return wareList;*/
    }

    @Override
    public List<WareHouse> findAbnormalByStatus(String status) {
        String sql = "select * from warehouse where status = ? order by wdate desc";
        List<WareHouse> wareList=template.query(sql, new BeanPropertyRowMapper<WareHouse>(WareHouse.class));
        return wareList;
    }

    @Override
    public int findTotalCount(Map<String, String[]> condition) {
        //定义初始化模板
        String sql = "select count(*) from warehouse where 1 = 1 ";
        StringBuilder sb = new StringBuilder(sql);
        //遍历map
        Set<String> keySet = condition.keySet();
        //定义参数集合
        List<Object> params=new ArrayList<Object>();
        for (String key : keySet) {
            if("currentPage".equals(key)||"rows".equals(key)||"method".equals(key)){
                continue;
            }
            //获取value
            String value = condition.get(key)[0];
            //判断value是否有值
            if (value != null && !"".equals(value)) {
                sb.append(" and " + key + " like ? ");
                params.add("%"+value+"%");//?条件的值
            }
        }

        return template.queryForObject(sb.toString(), Integer.class,params.toArray());
    }

    @Override
    public void addAbnormal(WareHouse wh) {
        String sql = "insert into warehouse values(?,?,?,?)";
        template.update(sql,wh.getWid(),wh.getWdate(),wh.getWimage(),wh.getStatus());
    }

    @Override
    public void delAbnormal(String wid) {
        String sql = " delete from warehouse where wid = ? ";
        template.update(sql, wid);
    }

    @Override
    public void updateAbnormal(String wid) {
        String sql = "update warehouse set status = ? where wid = ?";
        template.update(sql, 1,wid);
    }

    @Override
    public Integer findAllAbnormalByDate(String date) {
        String sql = "select count(*) from warehouse where wdate like ? ";

        return template.queryForObject(sql,Integer.class,"%"+date+"%");
    }

    @Override
    public int findProAbnormalByDate(String date) {
        String sql = "select count(*) from warehouse where status = 1 and wdate like ? ";

        return template.queryForObject(sql,Integer.class,"%"+date+"%");
    }

    @Override
    public int findPenAbnormalByDate(String date) {
        String sql = "select count(*) from warehouse where status = 0 and wdate like ? ";

        return template.queryForObject(sql,Integer.class,"%"+date+"%");
    }

    @Override
    public String findNewImg() {
        String sql = "SELECT * FROM `warehouse` where wdate  order by wdate desc LIMIT 1 , 1";
        List<WareHouse> wareList=template.query(sql, new BeanPropertyRowMapper<WareHouse>(WareHouse.class));
        return wareList.get(0).getWimage();
    }

    @Override
    public List<Face> findCountFace() {
        String sql = "SELECT * FROM face_info ";
        List<Face> faceList=template.query(sql, new BeanPropertyRowMapper<Face>(Face.class));
        return faceList;
    }
}

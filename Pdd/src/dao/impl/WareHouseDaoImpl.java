package dao.impl;

import dao.WareHouseDao;
import domain.WareHouse;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;

public class WareHouseImpl implements WareHouseDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public List<WareHouse> findAllAbnormal() {
        String sql = "select * from warehouse by wdate desc";
        List<WareHouse> wareList=template.query(sql, new BeanPropertyRowMapper<WareHouse>(WareHouse.class));
        return wareList;
    }

    @Override
    public List<WareHouse> findAbnormalByStatus(String status) {
        String sql = "select * from warehouse where by wdate desc";
        List<WareHouse> wareList=template.query(sql, new BeanPropertyRowMapper<WareHouse>(WareHouse.class));
        return wareList;
    }
}

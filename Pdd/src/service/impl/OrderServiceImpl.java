package service.impl;

import cn.itcast.jdbc.JdbcUtils;
import dao.OrderDao;
import dao.impl.OrderDaoImpl;
import domain.Order;
import domain.OrderItem;
import domain.PageBean;
import service.OrderService;
import util.JDBCUtils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;


public class OrderServiceImpl implements OrderService {
    @Override
    public void save(Order order) throws SQLException {
        Connection conn = null;
        conn = JDBCUtils.getConnection();
        //获取dao
        OrderDao od = new OrderDaoImpl();
        //1.开启事务
        //DataSourceUtils.startTransaction();
        conn.setAutoCommit(false);
        //2.向orders表中插入一条
        od.save(order);

        //3.向orderitem中插入n条
        for (OrderItem oi : order.getItems()) {
            od.saveItem(oi);
        }

        //4.事务控制
        //DataSourceUtils.commitAndClose();
        conn.commit();
    }

    /**
     * 我的订单
     *
     * @param pageNumber
     * @param pageSize
     * @param id
     * @return
     */
    @Override
    public PageBean<Order> findMyOrders(int pageNumber, int pageSize, int id) throws Exception {
        //获取dao
        OrderDao od = new OrderDaoImpl();
        //创建pagebean
        PageBean<Order> pb=new PageBean<>(pageNumber,pageSize);
        //查询总条数
        int totalRecord=od.getTotalRecord(id);
        pb.setTotalCount(totalRecord);
        //查询当前页数据
        List<Order> data=od.findMyOrderByPage(pb,id);
        pb.setList(data);

        return pb;
    }

    @Override
    public Order getById(String oid) throws Exception {
        OrderDao od=new OrderDaoImpl();
        return od.getById(oid);
    }

    @Override
    public void update(Order order) {
        OrderDao od=new OrderDaoImpl();
        od.updata(order);
    }

    /**
     * 后台查询订单
     * @param state
     * @return
     */
    @Override
    public List<Order> findAllByState(String state) {
        OrderDao od=new OrderDaoImpl();
        return od.findAllByState(state);
    }

    @Override
    public void deleteOrder(String oid) {
        OrderDao od=new OrderDaoImpl();
        od.delete(oid);
    }

    @Override
    public void createOrder(Order order) throws SQLException {
        /*try {
            JdbcUtils.beginTransaction();
            od.add(order);
            JdbcUtils.commitTransaction();
        } catch (SQLException e) {
            try {
                JdbcUtils.rollbackTransaction();
            } catch (SQLException e1) {}
            throw new RuntimeException(e);
        }*/
        Connection conn = null;
        conn = JDBCUtils.getConnection();
        //获取dao
        OrderDao od = new OrderDaoImpl();
        //1.开启事务
        //DataSourceUtils.startTransaction();
        conn.setAutoCommit(false);
        //2.向orders表中插入一条
        od.add(order);

        //4.事务控制
        //DataSourceUtils.commitAndClose();
        conn.commit();
    }

    @Override
    public Order load(String oid) throws SQLException {
        OrderDao od=new OrderDaoImpl();
        return od.load(oid);
    }

    @Override
    public int findStatus(String oid) throws SQLException {
        OrderDao od=new OrderDaoImpl();
        return od.findStatus(oid);
    }

    @Override
    public void updateStatus(String oid, int i) throws SQLException {
        OrderDao od=new OrderDaoImpl();
         od.updateStatus(oid,i);
    }
}

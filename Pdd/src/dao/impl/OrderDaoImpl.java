package dao.impl;

import cn.itcast.commons.CommonUtils;
import dao.OrderDao;
import domain.*;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.DataSourceUtils;
import util.JDBCUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class OrderDaoImpl implements OrderDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    private QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());

    @Override
    public void save(Order order) {
        String sql = "insert into orders values(?,?,?,?,?,?,?,?)";
        template.update(sql,order.getOid(),order.getOrdertime(),order.getTotal(),
                order.getState(),order.getAddress(),order.getName(),
                order.getTelephone(),order.getUser().getId());
    }

    @Override
    public void saveItem(OrderItem oi) {
        String sql = "insert into orderitem values(?,?,?,?,?)";
        template.update(sql, oi.getItemid(),oi.getCount(),oi.getSubtotal(),
                oi.getProduct().getPid(),oi.getOrder().getOid());
    }

    /**
     * 获取我的订单总体条数
     * @param id
     * @return
     */
    @Override
    public int getTotalRecord(int id) {
        String sql = "select count(*) from orders where uid = ?";
        int num=template.queryForObject(sql, Integer.class,id);
        return num;
    }

    /**
     * 获取我的订单当前页数据
     * @param pb
     * @param id
     * @return
     */
    @Override
    public List<Order> findMyOrderByPage(PageBean<Order> pb, int id) throws Exception{
        /*//查询所有订单(基本信息)
        String sql="select * from orders where uid = ? order by ordertime desc limit ?,?";
        List<Order> list = template.query(sql, new BeanPropertyRowMapper<Order>(Order.class), id,pb.getStartIndex(),pb.getPageSize());

        //遍历订单集合 获取每一个订单,查询每个订单订单项
        for (Order order : list) {
            sql=" SELECT * FROM orderitem oi , goods p WHERE oi.pid = p.pid AND oi.oid = ? ";
            List<Map<String, Object>> maplist = template.queryForList(sql, new MapListHandler(), order.getOid());

            //遍历maplist 获取每一个订单项详情,封装成orderitem,将其加入当前订单的订单项列表中
            for (Map<String, Object> map : maplist) {
                //1.封装成orderitem
                //a.创建orderitem
                OrderItem oi = new OrderItem();

                //b.封装orderitem
                BeanUtils.populate(oi, map);

                //c.手动封装product
                Product p = new Product();

                BeanUtils.populate(p, map);

                oi.setProduct(p);

                //2.将orderitem放入order的订单项列表
                order.getItems().add(oi);
            }
        }
        return list;*/
        QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
        //查询所有订单(基本信息)
        String sql="select * from orders where uid = ? order by ordertime  desc limit ?,? ";
        List<Order> list = qr.query(sql, new BeanListHandler<>(Order.class), id,pb.getStartIndex(),pb.getRows());

        //遍历订单集合 获取每一个订单,查询每个订单订单项
        for (Order order : list) {
            sql="SELECT * FROM orderitem oi,goods p WHERE oi.pid = p.pid AND oi.oid = ?";
            List<Map<String, Object>> maplist = qr.query(sql, new MapListHandler(), order.getOid());

            //遍历maplist 获取每一个订单项详情,封装成orderitem,将其加入当前订单的订单项列表中
            for (Map<String, Object> map : maplist) {
                //1.封装成orderitem
                //a.创建orderitem
                OrderItem oi = new OrderItem();

                //b.封装orderitem
                BeanUtils.populate(oi, map);

                //c.手动封装product
                Product p = new Product();

                BeanUtils.populate(p, map);

                oi.setProduct(p);

                //2.将orderitem放入order的订单项列表
                order.getItems().add(oi);
            }
        }
        return list;
    }

    @Override
    public Order getById(String oid) throws Exception {
        //查询订单详情
        String sql="select * from orders where oid = ?";
        Order order =template.queryForObject(sql,new BeanPropertyRowMapper<Order>(Order.class),oid);

        //查询订单项
        QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());
        sql ="SELECT * FROM orderitem oi,goods p WHERE oi.pid = p.pid AND oi.oid = ?";
        //所有的订单项详情
        List<Map<String, Object>> maplist = qr.query(sql, new MapListHandler(), oid);
        //遍历 获取每一个订单项详情 封装成orderitem 加入到当前订单的items中
        for (Map<String, Object> map : maplist) {
            //创建ordreitem
            OrderItem oi = new OrderItem();

            //封装
            BeanUtils.populate(oi, map);

            //手动封装product
            Product p = new Product();
            BeanUtils.populate(p, map);

            oi.setProduct(p);
            //将orderitem加入到订单的items中
            order.getItems().add(oi);
        }
        return order;
    }

    @Override
    public void updata(Order order) {
        String sql="update orders set state = ?,address = ?,name =?,telephone = ? where oid = ?";
        template.update(sql,order.getState(),order.getAddress(),order.getName(),
                order.getTelephone(),order.getOid());
    }

    @Override
    public List<Order> findAllByState(String state) {
        String sql = "select * from orders ";

        //判断state是否为空
        if(null==state || state.trim().length()==0){
            sql +=" order by ordertime desc";
            return template.query(sql, new BeanPropertyRowMapper<Order>(Order.class));
        }

        sql += " where state = ? order by ordertime desc";
        return template.query(sql, new BeanPropertyRowMapper<Order>(Order.class),state);
    }

    @Override
    public void delete(String oid) {
        //定义sql
        String sql = "delete from orders where oid = ?";
        //执行sql
        template.update(sql, oid);
    }

    @Override
    public void add(Order order) throws SQLException {
        /*
         * 1. 插入订单
         */
        String sql = "insert into orders values(?,?,?,?,?,?,?,?)";
        Object[] params = {order.getOid(), order.getOrdertime(),
                order.getTotal(),order.getState(),order.getAddress(),
                order.getName(),order.getTelephone(),order.getUser().getId()};
        qr.update(sql, params);

        /*
         * 2. 循环遍历订单的所有条目,让每个条目生成一个Object[]
         * 多个条目就对应Object[][]
         * 执行批处理，完成插入订单条目
         */
        sql = "insert into orderitem values(?,?,?,?,?)";
        int len = order.getOrderItemList().size();
        Object[][] objs = new Object[len][];
        for(int i = 0; i < len; i++){
            OrderItem item = order.getOrderItemList().get(i);
            objs[i] = new Object[]{item.getItemid(),item.getCount(),
                    item.getSubtotal(),item.getProduct().getPid(),
                    order.getOid()};
        }
        qr.batch(sql, objs);
    }


    /**
     * 查询订单状态
     * @param oid
     * @return
     * @throws SQLException
     */
    @Override
    public int findStatus(String oid) throws SQLException {
        String sql = "select state from orders where oid=?";
        Number number = (Number)qr.query(sql, new ScalarHandler(), oid);
        return number.intValue();
    }

    /**
     * 修改订单状态
     */
    @Override
    public void updateStatus(String oid, int status) throws SQLException {
        String sql = "update orders set state=? where oid=?";
        qr.update(sql, status, oid);
    }

    /**
     * 加载订单
     * @param oid
     * @return
     * @throws SQLException
     */
    @Override
    public Order load(String oid) throws SQLException {
        String sql = "select * from orders where oid=?";
        Order order = qr.query(sql, new BeanHandler<Order>(Order.class), oid);
        loadOrderItem(order);//为当前订单加载它的所有订单条目
        return order;
    }

    /*
     * 为指定的order载它的所有OrderItem
     */
    private void loadOrderItem(Order order) throws SQLException {
        /*
         * 1. 给sql语句select * from t_orderitem where oid=?
         * 2. 执行之，得到List<OrderItem>
         * 3. 设置给Order对象
         */
        String sql = "select * from orderitem a,goods p where a.oid= ? and a.pid=p.pid;";
        List<Map<String,Object>> mapList = qr.query(sql, new MapListHandler(), order.getOid());
        List<OrderItem> orderItemList = toOrderItemList(mapList);

        order.setOrderItemList(orderItemList);
    }
    /**
     * 把多个Map转换成多个OrderItem
     */
    private List<OrderItem> toOrderItemList(List<Map<String, Object>> mapList) {
        List<OrderItem> orderItemList = new ArrayList<OrderItem>();
        for(Map<String,Object> map : mapList) {
            OrderItem orderItem = toOrderItem(map);
            orderItemList.add(orderItem);
        }
        return orderItemList;
    }

    /*
     * 把一个Map转换成一个OrderItem
     */
    private OrderItem toOrderItem(Map<String, Object> map) {
        OrderItem orderItem = CommonUtils.toBean(map, OrderItem.class);
        Product product = CommonUtils.toBean(map, Product.class);
        orderItem.setProduct(product);
        return orderItem;
    }

}

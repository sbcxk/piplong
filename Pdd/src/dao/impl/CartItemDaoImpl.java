package dao.impl;


import cn.itcast.commons.CommonUtils;
import dao.CartItemDao;
import domain.CartItem;

import domain.Product;
import domain.User;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.springframework.jdbc.core.JdbcTemplate;
import util.DataSourceUtils;
import util.JDBCUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CartItemDaoImpl implements CartItemDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    private QueryRunner qr = new QueryRunner(DataSourceUtils.getDataSource());

    //将map映射成CartItem
    private CartItem toCartItem(Map<String,Object> map){
        if(map==null || map.size()==0)
            return null;
        CartItem cartItem= CommonUtils.toBean(map,CartItem.class);
        Product product = CommonUtils.toBean(map,Product.class);
        User user= CommonUtils.toBean(map,User.class);
        cartItem.setProduct(product);
        cartItem.setUser(user);
        return cartItem;
    }
    //将多个Map<List<map>> 映射为多个CartItem<LIst<cartitem>>
    private List<CartItem> toCartItemList(List<Map<String,Object>> mapList){
        List<CartItem> cartItemList=new ArrayList<>();
        for(Map<String,Object> map:mapList){
            CartItem cartItem=toCartItem(map);
            cartItemList.add(cartItem);
        }
        return cartItemList;
    }

    @Override
    public List<CartItem> findByUser(int uid) throws SQLException {

        String sql = "select * from cartitem c , goods p where c.pid = p.pid and uid = ? order by c.orderBy";
        List<Map<String , Object>> list_map=qr.query(sql,new MapListHandler(),uid);
        //System.out.println(list_map);
        return toCartItemList(list_map);
    }

    /*添加条目*/
    @Override
    public void add(CartItem cartItem) throws SQLException {
        String sql = "insert into cartitem(cartItemId, count , pid, uid)" +
                " values(?,?,?,?)";
        Object[] params = {cartItem.getCartItemId(), cartItem.getCount(),
                cartItem.getProduct().getPid(), cartItem.getUser().getId()};
        qr.update(sql, params);
    }

    /*查询某个用户购物车条目是否存在*/
    @Override
    public CartItem findByUidAndBid(String pid, int id) throws SQLException {
        String sql = "select * from cartitem where uid = ? and pid = ? ";
        Map<String,Object> map = qr.query(sql,new MapHandler(),id,pid);
        CartItem cartItem=toCartItem(map);
        return cartItem;
    }
    /*修改购物车条目数量*/
    @Override
    public void updateCount(String cartItemId, int total) {
        String sql="update cartitem set count = ? where cartItemId = ?";
        template.update(sql,total,cartItemId);
    }

    /*
     * 生成where子句
     */
    private String toWhereSql(int len) {
        StringBuilder sb = new StringBuilder("cartItemId in(");
        for(int i = 0; i < len; i++) {
            sb.append("?");
            if(i < len - 1) {
                sb.append(",");
            }
        }
        sb.append(")");
        return sb.toString();
    }

    /**
     * 批量删除
     */
    @Override
    public void batchDelete(String cartItemIds) throws SQLException {
        /*
         * 需要先把cartItemIds转换成数组
         * 1. 把cartItemIds转换成一个where子句
         * 2. 与delete from 连接在一起，然后执行之
         */
        Object[] cartItemIdArray = cartItemIds.split(",");
        String whereSql = toWhereSql(cartItemIdArray.length);
        String sql = "delete from cartitem where " + whereSql;
        qr.update(sql, cartItemIdArray);//其中cartItemIdArray必须是Object类型的数组！
    }

    /**
     * 按id查询
     */
    @Override
    public CartItem findByCartItemId(String cartItemId) throws SQLException {
        String sql = "select * from cartItem c, goods p where c.pid=p.pid and c.cartItemId=?";
        Map<String,Object> map = qr.query(sql, new MapHandler(), cartItemId);
        return toCartItem(map);
    }

    /**
     * 加载多个CartItem
     */
    @Override
    public List<CartItem> loadCartItems(String cartItemIds) throws SQLException {
        /*
         * 1. 把cartItemIds转换成数组
         */
        Object[] cartItemIdArray = cartItemIds.split(",");
        /*
         * 2. 生成wehre子句
         */
        String whereSql = toWhereSql(cartItemIdArray.length);
        /*
         * 3. 生成sql语句
         */
        String sql = "select * from cartitem c, goods p where c.pid=p.pid and " + whereSql;
        /*
         * 4. 执行sql，返回List<CartItem>
         */
        return toCartItemList(qr.query(sql, new MapListHandler(), cartItemIdArray));
    }
}

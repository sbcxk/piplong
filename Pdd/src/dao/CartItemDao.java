package dao;

import domain.CartItem;

import java.sql.SQLException;
import java.util.List;

public interface CartItemDao {
    /**
     * 通过用户查询购物车条目
     * @param uid
     * @return
     */
    List<CartItem> findByUser(int uid) throws SQLException;


    void add(CartItem cartItem) throws SQLException;

    CartItem findByUidAndBid(String pid, int id) throws SQLException;

    void updateCount(String cartItemId, int total);

    void batchDelete(String cartItemsIds) throws SQLException;

    CartItem findByCartItemId(String cartItemId) throws SQLException;

    List<CartItem> loadCartItems(String cartItemIds) throws SQLException;
}

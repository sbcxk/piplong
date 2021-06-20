package service;

import domain.Cart;
import domain.CartItem;

import java.sql.SQLException;
import java.util.List;

public interface CartItemService {
     List<CartItem> myCart(int uid) throws SQLException;

     /*加入购物车*/
     void add(CartItem cartItem) throws SQLException;

    void batchDelete(String cartItemsIds) throws SQLException;

    CartItem updateCount(String cartItemId, int quantity) throws SQLException;

    List<CartItem> loadCartItems(String cartItemIds) throws SQLException;
}

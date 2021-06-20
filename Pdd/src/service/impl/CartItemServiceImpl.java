package service.impl;

import cn.itcast.commons.CommonUtils;
import dao.CartItemDao;
import dao.impl.CartItemDaoImpl;
import domain.CartItem;
import service.CartItemService;

import java.sql.SQLException;
import java.util.List;

public class CartItemServiceImpl implements CartItemService {
    private final CartItemDao cartItemDao=new CartItemDaoImpl();
    public void add(CartItem cartItem) throws SQLException {
        try {
            CartItem has=cartItemDao.findByUidAndBid(cartItem.getProduct().getPid(),cartItem.getUser().getId());
            if(has==null){
                //如果购物车不存在
                cartItem.setCartItemId((CommonUtils.uuid()));
                cartItemDao.add(cartItem);
            }else {
                // 购物项存在
                int total=cartItem.getCount()+has.getCount();
                cartItemDao.updateCount(has.getCartItemId(),total);
            }
        }catch (Exception e){}

    }

    @Override
    public void batchDelete(String cartItemsIds) throws SQLException {
        cartItemDao.batchDelete(cartItemsIds);
    }

    @Override
    public CartItem updateCount(String cartItemId, int count) throws SQLException {
        cartItemDao.updateCount(cartItemId,count);
        return cartItemDao.findByCartItemId(cartItemId);
    }

    @Override
    public List<CartItem> loadCartItems(String cartItemIds) throws SQLException {
        return cartItemDao.loadCartItems(cartItemIds);
    }

    @Override
    public List<CartItem> myCart(int uid) throws SQLException {
        return cartItemDao.findByUser(uid);
    }

}

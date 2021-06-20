package domain;

import org.apache.commons.dbutils.QueryRunner;

import java.math.BigDecimal;

public class CartItem {
    private String cartItemId;        //购物项主键
    private Product product;        //商品
    private Integer count;          //数量
    private User user;              //所属用户

    public Double getSubtotal() {
        BigDecimal b1=new BigDecimal(product.getGood_price() + "");
        BigDecimal b2=new BigDecimal(count + "");
        BigDecimal b3=b1.multiply(b2);
        return b3.doubleValue();
    }

    public String getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(String cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    /*private Product product;    //商品
    private Double subtotal;    //小计
    private Integer count;      //数量

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    *//**
     * 获取商品小计
     * @return
     *//*
    public Double getSubtotal() {
        return product.getGood_price()*count;
    }

    *//*public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }*//*

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public CartItem(Product product, Integer count) {
        super();
        this.product = product;
        this.count = count;
    }*/
}

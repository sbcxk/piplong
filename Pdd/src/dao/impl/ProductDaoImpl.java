package dao.impl;

import constant.Constant;
import dao.ProductDao;
import domain.Product;
import domain.User;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;

public class ProductDaoImpl implements ProductDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public Product getById(String pid) {
        String sql="select * from goods where pid = ? ";
        return template.queryForObject(sql, new BeanPropertyRowMapper<Product>(Product.class), pid);
    }

    @Override
    public List<Product> findHot() {
        String sql="select * from goods where is_hot = ? and pflag = ? order by pdate desc limit 9";
        List<Product> hot = template.query(sql, new BeanPropertyRowMapper<Product>(Product.class), Constant.PRODUCT_IS_HOT,Constant.PRODUCT_IS_UP);
        return hot;
    }

    @Override
    public List<Product> findNew() {
        String sql="select * from goods where pflag = ? order by pdate desc";
        List<Product> New = template.query(sql, new BeanPropertyRowMapper<Product>(Product.class),Constant.PRODUCT_IS_UP);
        return New;
    }

    @Override
    public List<Product> findAll() {
        String sql = "select * from goods order by pdate desc";
        return template.query(sql, new BeanPropertyRowMapper<Product>(Product.class));
    }

    @Override
    public void save(Product p) {
        String sql="insert into goods(pid,pname,market_price,good_price,pimages,pdate,is_hot,pflag,pdesc,cid) values(?,?,?,?,?,?,?,?,?,?);";

        template.update(sql, p.getPid(),p.getPname(),p.getMarket_price(),
                p.getGood_price(),p.getPimages(),p.getPdate(),
                p.getIs_hot(),p.getPflag(),p.getPdesc(),
                p.getCategory().getCid());
    }

    @Override
    public void update(Product pd) {
        boolean status = pd.getPimages().contains(".");
        if(status){
            String sql = "update goods set pname = ? , market_price = ? , good_price = ? , pimages = ? , is_hot = ? , pflag = ? , pdesc = ? where pid = ?";
            template.update(sql, pd.getPname(), pd.getMarket_price(),
                    pd.getGood_price(), pd.getPimages(), pd.getIs_hot(),
                    pd.getPflag(), pd.getPdesc(),pd.getPid());
        }else{
            String sql = "update goods set pname = ? , market_price = ? , good_price = ? , is_hot = ? , pflag = ? , pdesc = ? where pid = ?";
            template.update(sql, pd.getPname(), pd.getMarket_price(),
                    pd.getGood_price(), pd.getIs_hot(),
                    pd.getPflag(), pd.getPdesc(),pd.getPid());
        }

    }

    @Override
    public void delete(String pid) {
        //??????sql
        String sql = "delete from goods where pid = ?";
        //??????sql
        template.update(sql, pid);
    }

    @Override
    public List<Product> findByProduct(String product) {
        String sql = "select * from goods where 1 = 1  ";
        if (product != null && !"".equals(product)) {
            sql+=" and pdesc like '%"+product+"%'";
        }
        List<Product> pro = template.query(sql, new BeanPropertyRowMapper<Product>(Product.class));
        return pro;
    }
}

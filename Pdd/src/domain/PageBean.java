package domain;

import java.util.List;

public class PageBean<T> {

    private int totalCount;//总记录数			页面传递过来
    private int totalPage;//总页数			计算出来 (int)Math.ceil(totalRecord*1.0/pageSize);
    private List<T> list;//当前页的数据		查询  limit (pageNumber-1)*pageSize,pageSize
    private int currentPage;//当前页码
    private int rows;//每页显示记录数

    public PageBean(int pageNumber, int pageSize) {
        super();
        this.currentPage = pageNumber;
        this.rows = pageSize;
    }

    public PageBean() {

    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }


    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    /**
     * 获取开始索引
     * @return
     */
    public int getStartIndex(){
        return (currentPage-1)*rows;
    }
    /**
     * 获取总页数
     * @return
     */
    public int getTotalPage() {
        return (int)Math.ceil(totalCount*1.0/rows);
    }

    @Override
    public String toString() {
        return "PageBean{" +
                "totalCount=" + totalCount +
                ", totalPage=" + totalPage +
                ", list=" + list +
                ", currentPage=" + currentPage +
                ", rows=" + rows +
                '}';
    }
}

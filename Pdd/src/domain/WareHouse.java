package domain;

import java.util.Date;

public class WareHouse {
    private String wid;
    private Date wdate;
    private String wimage;
    private Integer status;

    public String getWid() {
        return wid;
    }

    public void setWid(String wid) {
        this.wid = wid;
    }

    public Date getWdate() {
        return wdate;
    }

    public void setWdate(Date wdate) {
        this.wdate = wdate;
    }

    public String getWimage() {
        return wimage;
    }

    public void setWimage(String wimage) {
        this.wimage = wimage;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}

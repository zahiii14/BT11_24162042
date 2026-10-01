package vn.edu.fit.mssv24162042.entity;

import java.io.Serializable;

public class Category_24162042 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer categoryId;
    private String categoryname;
    private String categorycode;
    private String images;
    private Boolean status;
    private int videoCount; // For Câu 5 & 6

    public Category_24162042() {
    }

    public Category_24162042(Integer categoryId, String categoryname, String categorycode, String images, Boolean status) {
        this.categoryId = categoryId;
        this.categoryname = categoryname;
        this.categorycode = categorycode;
        this.images = images;
        this.status = status;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getCategorycode() {
        return categorycode;
    }

    public void setCategorycode(String categorycode) {
        this.categorycode = categorycode;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public int getVideoCount() {
        return videoCount;
    }

    public void setVideoCount(int videoCount) {
        this.videoCount = videoCount;
    }
}

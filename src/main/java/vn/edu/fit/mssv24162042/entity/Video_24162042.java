package vn.edu.fit.mssv24162042.entity;

import java.io.Serializable;

public class Video_24162042 implements Serializable {
    private static final long serialVersionUID = 1L;

    private String videoId;
    private String title;
    private String poster;
    private Integer views;
    private String description;
    private Boolean active;
    private Integer categoryId;

    // Additional fields for display (Câu 4 & Câu 5)
    private String categoryName;
    private int shareCount;
    private int likeCount;

    private Double price;

    public Video_24162042() {
    }

    public Video_24162042(String videoId, String title, String poster, Integer views, String description, Boolean active, Integer categoryId, Double price) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.views = views;
        this.description = description;
        this.active = active;
        this.categoryId = categoryId;
        this.price = price;
    }

    public Double getPrice() {
        return price != null ? price : 150000.0;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getShareCount() {
        return shareCount;
    }

    public void setShareCount(int shareCount) {
        this.shareCount = shareCount;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }
}

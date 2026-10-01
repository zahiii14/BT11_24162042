package vn.edu.fit.mssv24162042.entity;

import java.io.Serializable;

public class OrderDetail_24162042 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer orderDetailId;
    private Integer orderId;
    private String videoId;
    private Double price;
    private Integer quantity;
    private Double amount;

    private Video_24162042 video;

    public OrderDetail_24162042() {
    }

    public OrderDetail_24162042(Integer orderDetailId, Integer orderId, String videoId, Double price, Integer quantity, Double amount) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.videoId = videoId;
        this.price = price;
        this.quantity = quantity;
        this.amount = amount;
    }

    public Integer getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(Integer orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Video_24162042 getVideo() {
        return video;
    }

    public void setVideo(Video_24162042 video) {
        this.video = video;
    }
}

package vn.edu.fit.mssv24162042.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Order_24162042 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer orderId;
    private String username;
    private Date orderDate;
    private String fullname;
    private String phone;
    private String address;
    private String note;
    private Double totalAmount;
    private String paymentMethod;
    private String status; // Đơn hàng mới, Đã xác nhận, Chuẩn bị hàng, Vận chuyển, Giao hàng, Đã giao, Đơn hàng hủy, Đơn hàng hoàn

    private List<OrderDetail_24162042> details;

    public Order_24162042() {
    }

    public Order_24162042(Integer orderId, String username, Date orderDate, String fullname, String phone, String address, String note, Double totalAmount, String paymentMethod, String status) {
        this.orderId = orderId;
        this.username = username;
        this.orderDate = orderDate;
        this.fullname = fullname;
        this.phone = phone;
        this.address = address;
        this.note = note;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.status = status;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderDetail_24162042> getDetails() {
        return details;
    }

    public void setDetails(List<OrderDetail_24162042> details) {
        this.details = details;
    }

    public String getStatusBadgeClass() {
        if (status == null) return "bg-secondary";
        switch (status) {
            case "Đơn hàng mới": return "bg-primary";
            case "Đã xác nhận": return "bg-info text-dark";
            case "Chuẩn bị hàng": return "bg-warning text-dark";
            case "Vận chuyển": return "bg-primary text-white";
            case "Giao hàng": return "bg-info text-dark";
            case "Đã giao": return "bg-success";
            case "Đơn hàng hủy": return "bg-danger";
            case "Đơn hàng hoàn": return "bg-dark";
            default: return "bg-secondary";
        }
    }
}

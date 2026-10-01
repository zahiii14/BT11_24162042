package vn.edu.fit.mssv24162042.dao.impl;

import vn.edu.fit.mssv24162042.config.DBConnection_24162042;
import vn.edu.fit.mssv24162042.dao.IOrderDao_24162042;
import vn.edu.fit.mssv24162042.dao.IVideoDao_24162042;
import vn.edu.fit.mssv24162042.entity.Order_24162042;
import vn.edu.fit.mssv24162042.entity.OrderDetail_24162042;
import vn.edu.fit.mssv24162042.entity.Video_24162042;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImpl_24162042 implements IOrderDao_24162042 {

    private final IVideoDao_24162042 videoDao = new VideoDaoImpl_24162042();

    @Override
    public int createOrder(Order_24162042 order, List<OrderDetail_24162042> details) {
        String sqlOrder = "INSERT INTO Orders (Username, OrderDate, Fullname, Phone, Address, Note, TotalAmount, PaymentMethod, Status) VALUES (?, GETDATE(), ?, ?, ?, ?, ?, ?, ?)";
        String sqlDetail = "INSERT INTO OrderDetails (OrderId, VideoId, Price, Quantity, Amount) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection_24162042.getConnection()) {
            conn.setAutoCommit(false);
            int generatedOrderId = -1;

            try (PreparedStatement ps = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, order.getUsername());
                ps.setString(2, order.getFullname());
                ps.setString(3, order.getPhone());
                ps.setString(4, order.getAddress());
                ps.setString(5, order.getNote());
                ps.setDouble(6, order.getTotalAmount());
                ps.setString(7, order.getPaymentMethod() != null ? order.getPaymentMethod() : "COD");
                ps.setString(8, order.getStatus() != null ? order.getStatus() : "Đơn hàng mới");

                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedOrderId = rs.getInt(1);
                    }
                }
            }

            if (generatedOrderId > 0 && details != null) {
                try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                    for (OrderDetail_24162042 d : details) {
                        psDetail.setInt(1, generatedOrderId);
                        psDetail.setString(2, d.getVideoId());
                        psDetail.setDouble(3, d.getPrice());
                        psDetail.setInt(4, d.getQuantity());
                        psDetail.setDouble(5, d.getAmount());
                        psDetail.addBatch();
                    }
                    psDetail.executeBatch();
                }
            }

            conn.commit();
            return generatedOrderId;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public List<Order_24162042> findByUsername(String username) {
        List<Order_24162042> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE Username = ? ORDER BY OrderDate DESC";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapOrder(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Order_24162042> findByUsernameAndStatus(String username, String status) {
        if (status == null || status.trim().isEmpty() || "ALL".equalsIgnoreCase(status) || "Tất cả".equalsIgnoreCase(status)) {
            return findByUsername(username);
        }

        List<Order_24162042> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE Username = ? AND Status = ? ORDER BY OrderDate DESC";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapOrder(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Order_24162042 findById(int orderId) {
        String sql = "SELECT * FROM Orders WHERE OrderId = ?";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order_24162042 order = mapOrder(rs);
                    order.setDetails(findDetailsByOrderId(orderId));
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<OrderDetail_24162042> findDetailsByOrderId(int orderId) {
        List<OrderDetail_24162042> list = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetails WHERE OrderId = ?";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail_24162042 d = new OrderDetail_24162042();
                    d.setOrderDetailId(rs.getInt("OrderDetailId"));
                    d.setOrderId(rs.getInt("OrderId"));
                    d.setVideoId(rs.getString("VideoId"));
                    d.setPrice(rs.getDouble("Price"));
                    d.setQuantity(rs.getInt("Quantity"));
                    d.setAmount(rs.getDouble("Amount"));

                    // Load Video details for UI presentation
                    Video_24162042 v = videoDao.findById(d.getVideoId());
                    d.setVideo(v);

                    list.add(d);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean cancelOrder(int orderId, String username) {
        String sql = "UPDATE Orders SET Status = N'Đơn hàng hủy' WHERE OrderId = ? AND Username = ? AND Status = N'Đơn hàng mới'";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setString(2, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderId = ?";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int countByUsernameAndStatus(String username, String status) {
        String sql;
        boolean hasStatus = status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status) && !"Tất cả".equalsIgnoreCase(status);
        if (hasStatus) {
            sql = "SELECT COUNT(*) FROM Orders WHERE Username = ? AND Status = ?";
        } else {
            sql = "SELECT COUNT(*) FROM Orders WHERE Username = ?";
        }

        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            if (hasStatus) {
                ps.setString(2, status);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Order_24162042 mapOrder(ResultSet rs) throws Exception {
        Order_24162042 order = new Order_24162042();
        order.setOrderId(rs.getInt("OrderId"));
        order.setUsername(rs.getString("Username"));
        try {
            order.setOrderDate(rs.getTimestamp("OrderDate"));
        } catch (Exception ignored) {
            order.setOrderDate(rs.getDate("OrderDate"));
        }
        order.setFullname(rs.getString("Fullname"));
        order.setPhone(rs.getString("Phone"));
        order.setAddress(rs.getString("Address"));
        order.setNote(rs.getString("Note"));
        order.setTotalAmount(rs.getDouble("TotalAmount"));
        order.setPaymentMethod(rs.getString("PaymentMethod"));
        order.setStatus(rs.getString("Status"));
        return order;
    }
}

package vn.edu.fit.mssv24162042.service;

import vn.edu.fit.mssv24162042.entity.Order_24162042;
import vn.edu.fit.mssv24162042.entity.OrderDetail_24162042;

import java.util.List;

public interface IOrderService_24162042 {
    int createOrder(Order_24162042 order, List<OrderDetail_24162042> details);
    List<Order_24162042> findByUsername(String username);
    List<Order_24162042> findByUsernameAndStatus(String username, String status);
    Order_24162042 findById(int orderId);
    List<OrderDetail_24162042> findDetailsByOrderId(int orderId);
    boolean cancelOrder(int orderId, String username);
    boolean updateStatus(int orderId, String status);
    int countByUsernameAndStatus(String username, String status);
}

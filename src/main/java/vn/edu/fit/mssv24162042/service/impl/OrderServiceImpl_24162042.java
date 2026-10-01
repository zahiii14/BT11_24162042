package vn.edu.fit.mssv24162042.service.impl;

import vn.edu.fit.mssv24162042.dao.IOrderDao_24162042;
import vn.edu.fit.mssv24162042.dao.impl.OrderDaoImpl_24162042;
import vn.edu.fit.mssv24162042.entity.Order_24162042;
import vn.edu.fit.mssv24162042.entity.OrderDetail_24162042;
import vn.edu.fit.mssv24162042.service.IOrderService_24162042;

import java.util.List;

public class OrderServiceImpl_24162042 implements IOrderService_24162042 {

    private final IOrderDao_24162042 orderDao = new OrderDaoImpl_24162042();

    @Override
    public int createOrder(Order_24162042 order, List<OrderDetail_24162042> details) {
        return orderDao.createOrder(order, details);
    }

    @Override
    public List<Order_24162042> findByUsername(String username) {
        return orderDao.findByUsername(username);
    }

    @Override
    public List<Order_24162042> findByUsernameAndStatus(String username, String status) {
        return orderDao.findByUsernameAndStatus(username, status);
    }

    @Override
    public Order_24162042 findById(int orderId) {
        return orderDao.findById(orderId);
    }

    @Override
    public List<OrderDetail_24162042> findDetailsByOrderId(int orderId) {
        return orderDao.findDetailsByOrderId(orderId);
    }

    @Override
    public boolean cancelOrder(int orderId, String username) {
        return orderDao.cancelOrder(orderId, username);
    }

    @Override
    public boolean updateStatus(int orderId, String status) {
        return orderDao.updateStatus(orderId, status);
    }

    @Override
    public int countByUsernameAndStatus(String username, String status) {
        return orderDao.countByUsernameAndStatus(username, status);
    }
}

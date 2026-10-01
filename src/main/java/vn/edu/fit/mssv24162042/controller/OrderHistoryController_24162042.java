package vn.edu.fit.mssv24162042.controller;

import vn.edu.fit.mssv24162042.entity.Order_24162042;
import vn.edu.fit.mssv24162042.entity.User_24162042;
import vn.edu.fit.mssv24162042.service.IOrderService_24162042;
import vn.edu.fit.mssv24162042.service.impl.OrderServiceImpl_24162042;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {
    "/my-orders",
    "/order-detail",
    "/order-cancel",
    "/admin/order/update-status" // Helper endpoint to test status changes easily
})
public class OrderHistoryController_24162042 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService_24162042 orderService = new OrderServiceImpl_24162042();

    public static final String[] ALL_STATUSES = {
        "Đơn hàng mới",
        "Đã xác nhận",
        "Chuẩn bị hàng",
        "Vận chuyển",
        "Giao hàng",
        "Đã giao",
        "Đơn hàng hủy",
        "Đơn hàng hoàn"
    };

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        HttpSession session = req.getSession();
        User_24162042 account = (User_24162042) session.getAttribute("account");

        // Default test username if not logged in
        String username = (account != null) ? account.getUsername() : "user1";

        if (uri.endsWith("/order-detail")) {
            String idStr = req.getParameter("id");
            int orderId = -1;
            if (idStr != null) {
                try {
                    orderId = Integer.parseInt(idStr);
                } catch (NumberFormatException ignored) {}
            }

            Order_24162042 order = orderService.findById(orderId);
            if (order == null) {
                resp.sendRedirect(req.getContextPath() + "/my-orders");
                return;
            }

            req.setAttribute("order", order);
            req.setAttribute("allStatuses", ALL_STATUSES);
            req.getRequestDispatcher("/views/web/order-detail.jsp").forward(req, resp);
            return;
        }

        if (uri.endsWith("/order-cancel")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                try {
                    int orderId = Integer.parseInt(idStr);
                    boolean cancelled = orderService.cancelOrder(orderId, username);
                    if (cancelled) {
                        session.setAttribute("orderMsg", "Đã hủy đơn hàng #" + orderId + " thành công!");
                    } else {
                        session.setAttribute("orderError", "Không thể hủy đơn hàng #" + orderId + " (Chỉ đơn hàng ở trạng thái 'Đơn hàng mới' mới được hủy).");
                    }
                } catch (NumberFormatException ignored) {}
            }
            resp.sendRedirect(req.getContextPath() + "/my-orders");
            return;
        }

        // Helper endpoint to change status for observing dynamic status changes
        if (uri.endsWith("/admin/order/update-status")) {
            String idStr = req.getParameter("id");
            String status = req.getParameter("status");
            if (idStr != null && status != null) {
                try {
                    int orderId = Integer.parseInt(idStr);
                    orderService.updateStatus(orderId, status);
                    session.setAttribute("orderMsg", "Đã cập nhật trạng thái đơn hàng #" + orderId + " thành '" + status + "'!");
                } catch (Exception ignored) {}
            }
            String statusFilter = req.getParameter("currentFilter");
            if (statusFilter != null && !statusFilter.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/my-orders?status=" + java.net.URLEncoder.encode(statusFilter, "UTF-8"));
            } else {
                resp.sendRedirect(req.getContextPath() + "/my-orders");
            }
            return;
        }

        // Default: /my-orders - Order History with 8 status filter
        String selectedStatus = req.getParameter("status");
        if (selectedStatus == null || selectedStatus.trim().isEmpty()) {
            selectedStatus = "ALL";
        }

        List<Order_24162042> orders = orderService.findByUsernameAndStatus(username, selectedStatus);

        // Count for each status tab
        Map<String, Integer> statusCounts = new LinkedHashMap<>();
        int totalAll = orderService.countByUsernameAndStatus(username, "ALL");
        statusCounts.put("ALL", totalAll);

        for (String st : ALL_STATUSES) {
            int count = orderService.countByUsernameAndStatus(username, st);
            statusCounts.put(st, count);
        }

        req.setAttribute("orders", orders);
        req.setAttribute("selectedStatus", selectedStatus);
        req.setAttribute("statusCounts", statusCounts);
        req.setAttribute("allStatuses", ALL_STATUSES);
        req.setAttribute("currentUsername", username);

        req.getRequestDispatcher("/views/web/order-history.jsp").forward(req, resp);
    }
}

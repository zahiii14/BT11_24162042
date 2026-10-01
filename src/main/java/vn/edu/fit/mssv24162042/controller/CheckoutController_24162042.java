package vn.edu.fit.mssv24162042.controller;

import vn.edu.fit.mssv24162042.entity.CartItem_24162042;
import vn.edu.fit.mssv24162042.entity.Order_24162042;
import vn.edu.fit.mssv24162042.entity.OrderDetail_24162042;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutController_24162042 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService_24162042 orderService = new OrderServiceImpl_24162042();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem_24162042> cart = (List<CartItem_24162042>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        User_24162042 account = (User_24162042) session.getAttribute("account");
        req.setAttribute("account", account);
        req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem_24162042> cart = (List<CartItem_24162042>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        User_24162042 account = (User_24162042) session.getAttribute("account");
        String username = (account != null) ? account.getUsername() : "user1";

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");
        String paymentMethod = req.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD";
        }

        double totalAmount = 0.0;
        List<OrderDetail_24162042> details = new ArrayList<>();
        for (CartItem_24162042 item : cart) {
            double amt = item.getAmount();
            totalAmount += amt;
            OrderDetail_24162042 detail = new OrderDetail_24162042();
            detail.setVideoId(item.getVideo().getVideoId());
            detail.setPrice(item.getVideo().getPrice());
            detail.setQuantity(item.getQuantity());
            detail.setAmount(amt);
            details.add(detail);
        }

        Order_24162042 order = new Order_24162042();
        order.setUsername(username);
        order.setFullname(fullname);
        order.setPhone(phone);
        order.setAddress(address);
        order.setNote(note);
        order.setTotalAmount(totalAmount);
        order.setPaymentMethod(paymentMethod);
        order.setStatus("Đơn hàng mới"); // 1st status: NEW ORDER

        int orderId = orderService.createOrder(order, details);

        if (orderId > 0) {
            // Clear cart
            cart.clear();
            session.setAttribute("cart", cart);
            session.setAttribute("cartTotalItems", 0);
            session.setAttribute("cartTotalAmount", 0.0);

            session.setAttribute("checkoutSuccess", "Đặt hàng bằng COD thành công! Mã đơn hàng của bạn là #" + orderId);
            resp.sendRedirect(req.getContextPath() + "/order-detail?id=" + orderId);
        } else {
            req.setAttribute("error", "Có lỗi xảy ra trong quá trình xử lý đặt hàng. Vui lòng thử lại!");
            req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
        }
    }
}

package vn.edu.fit.mssv24162042.controller;

import vn.edu.fit.mssv24162042.entity.CartItem_24162042;
import vn.edu.fit.mssv24162042.entity.Video_24162042;
import vn.edu.fit.mssv24162042.service.IVideoService_24162042;
import vn.edu.fit.mssv24162042.service.impl.VideoServiceImpl_24162042;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {
    "/cart",
    "/cart/add",
    "/cart/update",
    "/cart/delete",
    "/cart/clear"
})
public class CartController_24162042 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IVideoService_24162042 videoService = new VideoServiceImpl_24162042();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem_24162042> cart = (List<CartItem_24162042>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if (uri.endsWith("/cart/add")) {
            String videoId = req.getParameter("id");
            int quantity = 1;
            try {
                String qtyStr = req.getParameter("quantity");
                if (qtyStr != null) quantity = Integer.parseInt(qtyStr);
            } catch (Exception ignored) {}

            if (videoId != null && !videoId.trim().isEmpty()) {
                Video_24162042 video = videoService.findById(videoId);
                if (video != null) {
                    boolean found = false;
                    for (CartItem_24162042 item : cart) {
                        if (item.getVideo().getVideoId().equalsIgnoreCase(videoId)) {
                            item.setQuantity(item.getQuantity() + quantity);
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        CartItem_24162042 newItem = new CartItem_24162042(video, quantity);
                        cart.add(newItem);
                    }
                }
            }
            updateCartSummary(session, cart);
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if (uri.endsWith("/cart/delete")) {
            String videoId = req.getParameter("id");
            if (videoId != null) {
                cart.removeIf(item -> item.getVideo().getVideoId().equalsIgnoreCase(videoId));
            }
            updateCartSummary(session, cart);
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if (uri.endsWith("/cart/clear")) {
            cart.clear();
            updateCartSummary(session, cart);
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // View Cart Page
        updateCartSummary(session, cart);
        req.getRequestDispatcher("/views/web/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem_24162042> cart = (List<CartItem_24162042>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        if (uri.endsWith("/cart/update")) {
            String videoId = req.getParameter("id");
            int quantity = 1;
            try {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            } catch (Exception ignored) {}

            if (videoId != null) {
                for (CartItem_24162042 item : cart) {
                    if (item.getVideo().getVideoId().equalsIgnoreCase(videoId)) {
                        item.setQuantity(quantity);
                        break;
                    }
                }
            }
            updateCartSummary(session, cart);
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void updateCartSummary(HttpSession session, List<CartItem_24162042> cart) {
        int totalItems = 0;
        double totalAmount = 0.0;
        for (CartItem_24162042 item : cart) {
            totalItems += item.getQuantity();
            totalAmount += item.getAmount();
        }
        session.setAttribute("cartTotalItems", totalItems);
        session.setAttribute("cartTotalAmount", totalAmount);
        session.setAttribute("cart", cart);
    }
}

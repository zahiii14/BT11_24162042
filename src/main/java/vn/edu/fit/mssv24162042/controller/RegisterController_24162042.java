package vn.edu.fit.mssv24162042.controller;

import vn.edu.fit.mssv24162042.entity.User_24162042;
import vn.edu.fit.mssv24162042.service.IUserService_24162042;
import vn.edu.fit.mssv24162042.service.impl.UserServiceImpl_24162042;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Random;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController_24162042 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService_24162042 userService = new UserServiceImpl_24162042();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String images = req.getParameter("images");

        if (images == null || images.trim().isEmpty()) {
            images = "https://i.pravatar.cc/150?img=1";
        }

        // Generate 6 digit OTP
        String otpCode = String.format("%06d", new Random().nextInt(900000) + 100000);

        User_24162042 user = new User_24162042();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullname(fullname);
        user.setEmail(email);
        user.setPhone(phone);
        user.setImages(images);
        user.setAdmin(false);

        boolean success = userService.register(user, otpCode);

        if (success) {
            HttpSession session = req.getSession();
            session.setAttribute("pendingUsername", username);
            session.setAttribute("pendingEmail", email);
            session.setAttribute("lastOtp", otpCode); // For easy testing in lab environment

            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại trong hệ thống!");
            req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
        }
    }
}

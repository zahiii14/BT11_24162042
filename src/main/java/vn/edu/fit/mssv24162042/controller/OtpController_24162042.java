package vn.edu.fit.mssv24162042.controller;

import vn.edu.fit.mssv24162042.service.IUserService_24162042;
import vn.edu.fit.mssv24162042.service.impl.UserServiceImpl_24162042;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/verify-otp"})
public class OtpController_24162042 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService_24162042 userService = new UserServiceImpl_24162042();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/web/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String otpCode = req.getParameter("otp");

        HttpSession session = req.getSession();
        if (username == null || username.trim().isEmpty()) {
            username = (String) session.getAttribute("pendingUsername");
        }

        boolean verified = userService.verifyOtp(username, otpCode);

        if (verified) {
            req.setAttribute("message", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.");
            req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Mã OTP không đúng hoặc tài khoản không hợp lệ!");
            req.getRequestDispatcher("/views/web/verify-otp.jsp").forward(req, resp);
        }
    }
}

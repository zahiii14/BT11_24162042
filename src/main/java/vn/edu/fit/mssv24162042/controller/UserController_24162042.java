package vn.edu.fit.mssv24162042.controller;

import vn.edu.fit.mssv24162042.entity.User_24162042;
import vn.edu.fit.mssv24162042.service.IUserService_24162042;
import vn.edu.fit.mssv24162042.service.impl.UserServiceImpl_24162042;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
    "/admin/users",
    "/admin/user/add",
    "/admin/user/edit",
    "/admin/user/delete",
    "/admin/user/save"
})
public class UserController_24162042 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService_24162042 userService = new UserServiceImpl_24162042();
    private static final int PAGE_SIZE = 6; // 6 users per page as requested in Câu 3

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.endsWith("/admin/user/add")) {
            req.setAttribute("user", new User_24162042());
            req.setAttribute("isEdit", false);
            req.getRequestDispatcher("/views/admin/user-form.jsp").forward(req, resp);
            return;
        }

        if (uri.endsWith("/admin/user/edit")) {
            String username = req.getParameter("username");
            User_24162042 user = userService.findByUsername(username);
            req.setAttribute("user", user);
            req.setAttribute("isEdit", true);
            req.getRequestDispatcher("/views/admin/user-form.jsp").forward(req, resp);
            return;
        }

        if (uri.endsWith("/admin/user/delete")) {
            String username = req.getParameter("username");
            if (username != null && !username.trim().isEmpty()) {
                userService.delete(username);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/users");
            return;
        }

        // Default: List users with pagination 6 per page
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException ignored) {}
        }
        if (page < 1) page = 1;

        int totalUsers = userService.count();
        int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<User_24162042> userList = userService.findAll(page, PAGE_SIZE);

        req.setAttribute("userList", userList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalUsers", totalUsers);
        req.getRequestDispatcher("/views/admin/user-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        if (uri.endsWith("/admin/user/save")) {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String images = req.getParameter("images");
            boolean isAdmin = "true".equalsIgnoreCase(req.getParameter("admin")) || "on".equalsIgnoreCase(req.getParameter("admin"));
            boolean isActive = "true".equalsIgnoreCase(req.getParameter("active")) || "on".equalsIgnoreCase(req.getParameter("active"));
            boolean isEdit = "true".equalsIgnoreCase(req.getParameter("isEdit"));

            User_24162042 user = new User_24162042(username, password, phone, fullname, email, isAdmin, isActive, images, null);

            if (isEdit) {
                userService.update(user);
            } else {
                userService.insert(user);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }
}

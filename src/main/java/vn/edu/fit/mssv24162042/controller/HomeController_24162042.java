package vn.edu.fit.mssv24162042.controller;

import vn.edu.fit.mssv24162042.entity.Category_24162042;
import vn.edu.fit.mssv24162042.entity.Video_24162042;
import vn.edu.fit.mssv24162042.service.ICategoryService_24162042;
import vn.edu.fit.mssv24162042.service.IVideoService_24162042;
import vn.edu.fit.mssv24162042.service.impl.CategoryServiceImpl_24162042;
import vn.edu.fit.mssv24162042.service.impl.VideoServiceImpl_24162042;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/home", ""})
public class HomeController_24162042 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ICategoryService_24162042 categoryService = new CategoryServiceImpl_24162042();
    private final IVideoService_24162042 videoService = new VideoServiceImpl_24162042();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category_24162042> categories = categoryService.findAllWithVideoCount();
        List<Video_24162042> videos = videoService.findAll();

        req.setAttribute("categories", categories);
        req.setAttribute("videos", videos);
        req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
    }
}

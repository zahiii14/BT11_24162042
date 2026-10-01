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

@WebServlet(urlPatterns = {"/videos", "/category/videos"})
public class VideoCategoryController_24162042 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ICategoryService_24162042 categoryService = new CategoryServiceImpl_24162042();
    private final IVideoService_24162042 videoService = new VideoServiceImpl_24162042();
    private static final int PAGE_SIZE = 3; // 3 videos per page as requested in Câu 5

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category_24162042> categories = categoryService.findAllWithVideoCount(); // Câu 6: Count videos per category

        int categoryId = 1;
        String catIdStr = req.getParameter("categoryId");
        if (catIdStr != null && !catIdStr.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(catIdStr);
            } catch (NumberFormatException ignored) {}
        } else if (!categories.isEmpty()) {
            categoryId = categories.get(0).getCategoryId();
        }

        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException ignored) {}
        }
        if (page < 1) page = 1;

        Category_24162042 currentCategory = categoryService.findById(categoryId);
        int totalVideos = videoService.countByCategoryId(categoryId);
        int totalPages = (int) Math.ceil((double) totalVideos / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Video_24162042> videoList = videoService.findByCategoryId(categoryId, page, PAGE_SIZE);

        req.setAttribute("categories", categories);
        req.setAttribute("currentCategory", currentCategory);
        req.setAttribute("videoList", videoList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalVideos", totalVideos);
        req.setAttribute("categoryId", categoryId);

        req.getRequestDispatcher("/views/web/video-category.jsp").forward(req, resp);
    }
}

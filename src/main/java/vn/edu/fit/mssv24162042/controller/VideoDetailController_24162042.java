package vn.edu.fit.mssv24162042.controller;

import vn.edu.fit.mssv24162042.entity.Video_24162042;
import vn.edu.fit.mssv24162042.service.IVideoService_24162042;
import vn.edu.fit.mssv24162042.service.impl.VideoServiceImpl_24162042;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/video/detail"})
public class VideoDetailController_24162042 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IVideoService_24162042 videoService = new VideoServiceImpl_24162042();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String videoId = req.getParameter("id");
        if (videoId == null || videoId.trim().isEmpty()) {
            videoId = "V01"; // default video ID for quick viewing
        }

        Video_24162042 video = videoService.findById(videoId);
        req.setAttribute("video", video);
        req.getRequestDispatcher("/views/web/video-detail.jsp").forward(req, resp);
    }
}

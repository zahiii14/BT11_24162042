package vn.edu.fit.mssv24162042.service.impl;

import vn.edu.fit.mssv24162042.dao.IVideoDao_24162042;
import vn.edu.fit.mssv24162042.dao.impl.VideoDaoImpl_24162042;
import vn.edu.fit.mssv24162042.entity.Video_24162042;
import vn.edu.fit.mssv24162042.service.IVideoService_24162042;

import java.util.List;

public class VideoServiceImpl_24162042 implements IVideoService_24162042 {

    private final IVideoDao_24162042 videoDao = new VideoDaoImpl_24162042();

    @Override
    public Video_24162042 findById(String videoId) {
        return videoDao.findById(videoId);
    }

    @Override
    public List<Video_24162042> findByCategoryId(int categoryId, int page, int pageSize) {
        return videoDao.findByCategoryId(categoryId, page, pageSize);
    }

    @Override
    public int countByCategoryId(int categoryId) {
        return videoDao.countByCategoryId(categoryId);
    }

    @Override
    public List<Video_24162042> findAll() {
        return videoDao.findAll();
    }
}

package vn.edu.fit.mssv24162042.service;

import vn.edu.fit.mssv24162042.entity.Video_24162042;
import java.util.List;

public interface IVideoService_24162042 {
    Video_24162042 findById(String videoId);
    List<Video_24162042> findByCategoryId(int categoryId, int page, int pageSize);
    int countByCategoryId(int categoryId);
    List<Video_24162042> findAll();
}

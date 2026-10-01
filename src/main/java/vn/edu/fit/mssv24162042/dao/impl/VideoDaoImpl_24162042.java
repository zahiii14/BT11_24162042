package vn.edu.fit.mssv24162042.dao.impl;

import vn.edu.fit.mssv24162042.config.DBConnection_24162042;
import vn.edu.fit.mssv24162042.dao.IVideoDao_24162042;
import vn.edu.fit.mssv24162042.entity.Video_24162042;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class VideoDaoImpl_24162042 implements IVideoDao_24162042 {

    @Override
    public Video_24162042 findById(String videoId) {
        String sql = "SELECT v.*, c.Categoryname, " +
                     "(SELECT COUNT(*) FROM Shares s WHERE s.VideoId = v.VideoId) AS ShareCount, " +
                     "(SELECT COUNT(*) FROM Favorites f WHERE f.VideoId = v.VideoId) AS LikeCount " +
                     "FROM Videos v " +
                     "LEFT JOIN Category c ON v.CategoryId = c.CategoryId " +
                     "WHERE v.VideoId = ?";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, videoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapVideo(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Video_24162042> findByCategoryId(int categoryId, int page, int pageSize) {
        List<Video_24162042> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT v.*, c.Categoryname, " +
                     "(SELECT COUNT(*) FROM Shares s WHERE s.VideoId = v.VideoId) AS ShareCount, " +
                     "(SELECT COUNT(*) FROM Favorites f WHERE f.VideoId = v.VideoId) AS LikeCount " +
                     "FROM Videos v " +
                     "LEFT JOIN Category c ON v.CategoryId = c.CategoryId " +
                     "WHERE v.CategoryId = ? AND v.Active = 1 " +
                     "ORDER BY v.VideoId ASC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapVideo(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countByCategoryId(int categoryId) {
        String sql = "SELECT COUNT(*) FROM Videos WHERE CategoryId = ? AND Active = 1";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Video_24162042> findAll() {
        List<Video_24162042> list = new ArrayList<>();
        String sql = "SELECT v.*, c.Categoryname, " +
                     "(SELECT COUNT(*) FROM Shares s WHERE s.VideoId = v.VideoId) AS ShareCount, " +
                     "(SELECT COUNT(*) FROM Favorites f WHERE f.VideoId = v.VideoId) AS LikeCount " +
                     "FROM Videos v " +
                     "LEFT JOIN Category c ON v.CategoryId = c.CategoryId " +
                     "WHERE v.Active = 1 " +
                     "ORDER BY v.VideoId ASC";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapVideo(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Video_24162042 mapVideo(ResultSet rs) throws Exception {
        Video_24162042 video = new Video_24162042();
        video.setVideoId(rs.getString("VideoId"));
        video.setTitle(rs.getString("Title"));
        video.setPoster(rs.getString("Poster"));
        video.setViews(rs.getInt("Views"));
        video.setDescription(rs.getString("Description"));
        video.setActive(rs.getBoolean("Active"));
        video.setCategoryId(rs.getInt("CategoryId"));
        
        try {
            video.setPrice(rs.getDouble("Price"));
        } catch (Exception ignored) {
            video.setPrice(150000.0);
        }

        try {
            video.setCategoryName(rs.getString("Categoryname"));
        } catch (Exception ignored) {}

        try {
            video.setShareCount(rs.getInt("ShareCount"));
        } catch (Exception ignored) {}

        try {
            video.setLikeCount(rs.getInt("LikeCount"));
        } catch (Exception ignored) {}

        return video;
    }
}

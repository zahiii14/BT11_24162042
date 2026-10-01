package vn.edu.fit.mssv24162042.dao.impl;

import vn.edu.fit.mssv24162042.config.DBConnection_24162042;
import vn.edu.fit.mssv24162042.dao.ICategoryDao_24162042;
import vn.edu.fit.mssv24162042.entity.Category_24162042;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl_24162042 implements ICategoryDao_24162042 {

    @Override
    public List<Category_24162042> findAll() {
        List<Category_24162042> list = new ArrayList<>();
        String sql = "SELECT * FROM Category WHERE Status = 1";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category_24162042 cat = mapCategory(rs);
                list.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Category_24162042 findById(int id) {
        String sql = "SELECT * FROM Category WHERE CategoryId = ?";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapCategory(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Category_24162042> findAllWithVideoCount() {
        List<Category_24162042> list = new ArrayList<>();
        String sql = "SELECT c.*, COUNT(v.VideoId) AS VideoCount " +
                     "FROM Category c LEFT JOIN Videos v ON c.CategoryId = v.CategoryId AND v.Active = 1 " +
                     "WHERE c.Status = 1 " +
                     "GROUP BY c.CategoryId, c.Categoryname, c.Categorycode, c.Images, c.Status";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category_24162042 cat = mapCategory(rs);
                cat.setVideoCount(rs.getInt("VideoCount"));
                list.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Category_24162042 mapCategory(ResultSet rs) throws Exception {
        Category_24162042 cat = new Category_24162042();
        cat.setCategoryId(rs.getInt("CategoryId"));
        cat.setCategoryname(rs.getString("Categoryname"));
        cat.setCategorycode(rs.getString("Categorycode"));
        cat.setImages(rs.getString("Images"));
        cat.setStatus(rs.getBoolean("Status"));
        return cat;
    }
}

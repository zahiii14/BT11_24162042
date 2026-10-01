package vn.edu.fit.mssv24162042.dao.impl;

import vn.edu.fit.mssv24162042.config.DBConnection_24162042;
import vn.edu.fit.mssv24162042.dao.IUserDao_24162042;
import vn.edu.fit.mssv24162042.entity.User_24162042;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl_24162042 implements IUserDao_24162042 {

    @Override
    public User_24162042 findByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE Username = ?";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User_24162042 findByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void insert(User_24162042 user) {
        String sql = "INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images, Otp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getFullname());
            ps.setString(5, user.getEmail());
            ps.setBoolean(6, user.getAdmin() != null ? user.getAdmin() : false);
            ps.setBoolean(7, user.getActive() != null ? user.getActive() : false);
            ps.setString(8, user.getImages());
            ps.setString(9, user.getOtp());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(User_24162042 user) {
        String sql = "UPDATE Users SET Password = ?, Phone = ?, Fullname = ?, Email = ?, Admin = ?, Active = ?, Images = ?, Otp = ? WHERE Username = ?";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getPassword());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setBoolean(5, user.getAdmin() != null ? user.getAdmin() : false);
            ps.setBoolean(6, user.getActive() != null ? user.getActive() : false);
            ps.setString(7, user.getImages());
            ps.setString(8, user.getOtp());
            ps.setString(9, user.getUsername());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(String username) {
        String sql = "DELETE FROM Users WHERE Username = ?";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User_24162042> findAll() {
        List<User_24162042> list = new ArrayList<>();
        String sql = "SELECT * FROM Users ORDER BY Username ASC";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<User_24162042> findAll(int page, int pageSize) {
        List<User_24162042> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Users ORDER BY Username ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapUser(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (Connection conn = DBConnection_24162042.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private User_24162042 mapUser(ResultSet rs) throws Exception {
        User_24162042 user = new User_24162042();
        user.setUsername(rs.getString("Username"));
        user.setPassword(rs.getString("Password"));
        user.setPhone(rs.getString("Phone"));
        user.setFullname(rs.getString("Fullname"));
        user.setEmail(rs.getString("Email"));
        user.setAdmin(rs.getBoolean("Admin"));
        user.setActive(rs.getBoolean("Active"));
        user.setImages(rs.getString("Images"));
        try {
            user.setOtp(rs.getString("Otp"));
        } catch (Exception ignored) {}
        return user;
    }
}

package vn.edu.fit.mssv24162042.service.impl;

import vn.edu.fit.mssv24162042.dao.IUserDao_24162042;
import vn.edu.fit.mssv24162042.dao.impl.UserDaoImpl_24162042;
import vn.edu.fit.mssv24162042.entity.User_24162042;
import vn.edu.fit.mssv24162042.service.IUserService_24162042;
import vn.edu.fit.mssv24162042.utils.EmailUtils_24162042;

import java.util.List;

public class UserServiceImpl_24162042 implements IUserService_24162042 {

    private final IUserDao_24162042 userDao = new UserDaoImpl_24162042();

    @Override
    public User_24162042 login(String username, String password) {
        User_24162042 user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password) && Boolean.TRUE.equals(user.getActive())) {
            return user;
        }
        return null;
    }

    @Override
    public boolean register(User_24162042 user, String otpCode) {
        if (userDao.findByUsername(user.getUsername()) != null) {
            return false;
        }
        user.setActive(false); // Inactive until OTP verification
        user.setOtp(otpCode);
        userDao.insert(user);
        
        // Send OTP mail
        EmailUtils_24162042.sendOtpEmail(user.getEmail(), otpCode);
        return true;
    }

    @Override
    public boolean verifyOtp(String usernameOrEmail, String otpCode) {
        User_24162042 user = userDao.findByUsername(usernameOrEmail);
        if (user == null) {
            user = userDao.findByEmail(usernameOrEmail);
        }
        if (user != null && otpCode != null && otpCode.equals(user.getOtp())) {
            user.setActive(true);
            user.setOtp(null);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public User_24162042 findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User_24162042 findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void insert(User_24162042 user) {
        userDao.insert(user);
    }

    @Override
    public void update(User_24162042 user) {
        userDao.update(user);
    }

    @Override
    public void delete(String username) {
        userDao.delete(username);
    }

    @Override
    public List<User_24162042> findAll() {
        return userDao.findAll();
    }

    @Override
    public List<User_24162042> findAll(int page, int pageSize) {
        return userDao.findAll(page, pageSize);
    }

    @Override
    public int count() {
        return userDao.count();
    }
}

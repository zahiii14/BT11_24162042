package vn.edu.fit.mssv24162042.service;

import vn.edu.fit.mssv24162042.entity.User_24162042;
import java.util.List;

public interface IUserService_24162042 {
    User_24162042 login(String username, String password);
    boolean register(User_24162042 user, String otpCode);
    boolean verifyOtp(String emailOrUsername, String otpCode);
    User_24162042 findByUsername(String username);
    User_24162042 findByEmail(String email);
    void insert(User_24162042 user);
    void update(User_24162042 user);
    void delete(String username);
    List<User_24162042> findAll();
    List<User_24162042> findAll(int page, int pageSize);
    int count();
}

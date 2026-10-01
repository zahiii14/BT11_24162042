package vn.edu.fit.mssv24162042.service;

import vn.edu.fit.mssv24162042.entity.Category_24162042;
import java.util.List;

public interface ICategoryService_24162042 {
    List<Category_24162042> findAll();
    Category_24162042 findById(int id);
    List<Category_24162042> findAllWithVideoCount();
}

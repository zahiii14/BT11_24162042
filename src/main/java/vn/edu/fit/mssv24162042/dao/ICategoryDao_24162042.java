package vn.edu.fit.mssv24162042.dao;

import vn.edu.fit.mssv24162042.entity.Category_24162042;
import java.util.List;

public interface ICategoryDao_24162042 {
    List<Category_24162042> findAll();
    Category_24162042 findById(int id);
    List<Category_24162042> findAllWithVideoCount(); // For Câu 5 & 6
}

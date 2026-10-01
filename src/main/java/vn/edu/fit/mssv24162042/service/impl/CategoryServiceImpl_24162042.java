package vn.edu.fit.mssv24162042.service.impl;

import vn.edu.fit.mssv24162042.dao.ICategoryDao_24162042;
import vn.edu.fit.mssv24162042.dao.impl.CategoryDaoImpl_24162042;
import vn.edu.fit.mssv24162042.entity.Category_24162042;
import vn.edu.fit.mssv24162042.service.ICategoryService_24162042;

import java.util.List;

public class CategoryServiceImpl_24162042 implements ICategoryService_24162042 {

    private final ICategoryDao_24162042 categoryDao = new CategoryDaoImpl_24162042();

    @Override
    public List<Category_24162042> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public Category_24162042 findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public List<Category_24162042> findAllWithVideoCount() {
        return categoryDao.findAllWithVideoCount();
    }
}

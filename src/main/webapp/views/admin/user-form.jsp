<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${isEdit ? 'Cập Nhật User' : 'Thêm User Mới'} - Admin 24162042</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-md-7">
        <div class="card shadow border-0 rounded-3">
            <div class="card-header bg-primary text-white py-3 d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold">
                    <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-person-plus-fill'} me-2"></i>
                    ${isEdit ? 'CẬP NHẬT THÔNG TIN USER' : 'THÊM THÀNH VIÊN MỚI'}
                </h5>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại
                </a>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/user/save" method="post">
                    <input type="hidden" name="isEdit" value="${isEdit}" />

                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold">Tên đăng nhập (Username) *</label>
                        <input type="text" class="form-control" id="username" name="username" 
                               value="${user.username}" ${isEdit ? 'readonly' : 'required'}>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label fw-semibold">Mật khẩu *</label>
                        <input type="password" class="form-control" id="password" name="password" 
                               value="${user.password}" required>
                    </div>

                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-semibold">Họ và Tên *</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" 
                               value="${user.fullname}" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label fw-semibold">Email *</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="${user.email}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                            <input type="text" class="form-control" id="phone" name="phone" 
                                   value="${user.phone}">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="images" class="form-label fw-semibold">URL Ảnh đại diện</label>
                        <input type="text" class="form-control" id="images" name="images" 
                               value="${user.images}">
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="admin" name="admin" value="true" ${user.admin ? 'checked' : ''}>
                                <label class="form-check-label fw-semibold" for="admin">Quyền Admin</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="active" name="active" value="true" ${user.active ? 'checked' : ''}>
                                <label class="form-check-label fw-semibold" for="active">Kích hoạt (Active)</label>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary fw-bold px-4">
                            <i class="bi bi-save-fill me-1"></i>Lưu Dữ Liệu
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary px-4">Hủy Bỏ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>

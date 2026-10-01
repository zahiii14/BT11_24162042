<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Ký Tài Khoản - 24162042</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-header bg-success text-white text-center py-3">
                <h4 class="mb-0 fw-bold"><i class="bi bi-person-plus-fill me-2"></i>ĐĂNG KÝ TÀI KHOẢN (OTP)</h4>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label fw-semibold">Tên đăng nhập *</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label fw-semibold">Mật khẩu *</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-semibold">Họ và Tên *</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label fw-semibold">Email nhận OTP *</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="example@gmail.com" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                            <input type="text" class="form-control" id="phone" name="phone">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="images" class="form-label fw-semibold">URL Ảnh đại diện</label>
                        <input type="text" class="form-control" id="images" name="images" placeholder="https://i.pravatar.cc/150">
                    </div>
                    <button type="submit" class="btn btn-success w-100 py-2 fw-bold">
                        <i class="bi bi-envelope-paper-fill me-2"></i>Đăng Ký & Nhận Mã OTP
                    </button>
                </form>

                <div class="text-center mt-3">
                    <p class="mb-0 text-muted">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-success text-decoration-none fw-bold">Đăng nhập</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

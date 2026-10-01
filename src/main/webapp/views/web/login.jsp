<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập - 24162042</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-md-5">
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-header bg-primary text-white text-center py-3">
                <h4 class="mb-0 fw-bold"><i class="bi bi-box-arrow-in-right me-2"></i>ĐĂNG NHẬP HỆ THỐNG</h4>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold">Tên đăng nhập (Username)</label>
                        <input type="text" class="form-control" id="username" name="username" placeholder="Nhập admin hoặc user1..." required autofocus>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label fw-semibold">Mật khẩu (Password)</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu..." required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">
                        <i class="bi bi-box-arrow-in-right me-1"></i>Đăng Nhập
                    </button>
                </form>

                <div class="text-center mt-3">
                    <p class="mb-0 text-muted">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="text-primary text-decoration-none fw-bold">Đăng ký ngay</a></p>
                </div>

                <hr class="my-4">
                <div class="bg-light p-3 rounded text-muted small">
                    <strong>Gợi ý tài khoản thử nghiệm:</strong><br>
                    - Admin: Username: <code>admin</code> | Password: <code>123</code><br>
                    - User: Username: <code>user1</code> | Password: <code>123</code>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

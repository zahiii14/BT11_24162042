<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác Thực OTP - 24162042</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-md-5">
        <div class="card shadow-lg border-0 rounded-4">
            <div class="card-header bg-warning text-dark text-center py-3">
                <h4 class="mb-0 fw-bold"><i class="bi bi-shield-check me-2"></i>KÍCH HOẠT TÀI KHOẢN BẰNG OTP</h4>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="alert alert-info small mb-3">
                    <i class="bi bi-info-circle-fill me-1"></i>
                    Mã OTP kích hoạt gồm 6 chữ số đã được hệ thống gửi tới Email của bạn 
                    (Tài khoản: <strong>${sessionScope.pendingUsername}</strong>).
                </div>

                <c:if test="${not empty sessionScope.lastOtp}">
                    <div class="alert alert-success fw-bold text-center mb-3">
                        <i class="bi bi-key-fill me-2"></i>MÃ OTP THỬ NGHIỆM: <span class="fs-4 text-danger">${sessionScope.lastOtp}</span>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold">Tên đăng nhập / Email</label>
                        <input type="text" class="form-control" id="username" name="username" value="${sessionScope.pendingUsername}" required>
                    </div>
                    <div class="mb-3">
                        <label for="otp" class="form-label fw-semibold">Nhập mã OTP (6 chữ số)</label>
                        <input type="text" class="form-control form-control-lg text-center letter-spacing-2" id="otp" name="otp" placeholder="123456" maxlength="6" required autofocus>
                    </div>
                    <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark">
                        <i class="bi bi-check-circle-fill me-2"></i>Kích Hoạt Tài Khoản
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>

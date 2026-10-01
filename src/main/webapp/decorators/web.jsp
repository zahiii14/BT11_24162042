<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><decorator:title default="Trang Web Video 24162042"/></title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { min-height: 100vh; display: flex; flex-direction: column; background-color: #f8f9fa; }
        .main-content { flex: 1; }
        footer { background-color: #212529; color: white; margin-top: auto; }
        .nav-link.active { font-weight: bold; border-bottom: 2px solid #0d6efd; }
    </style>
    <decorator:head/>
</head>
<body>

    <!-- HEADER MENU -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/home">
                    <i class="bi bi-play-btn-fill me-2"></i>WEB VIDEO 24162042
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                                <i class="bi bi-house-door-fill me-1"></i>Trang Chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/videos">
                                <i class="bi bi-film me-1"></i>Sản Phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-info fw-semibold" href="${pageContext.request.contextPath}/my-orders">
                                <i class="bi bi-clock-history me-1"></i>Đơn Hàng Của Tôi
                            </a>
                        </li>
                        <c:if test="${not empty sessionScope.account && sessionScope.account.admin}">
                            <li class="nav-item">
                                <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/admin/users">
                                    <i class="bi bi-gear-fill me-1"></i>Trang Quản Trị
                                </a>
                            </li>
                        </c:if>
                    </ul>
                    <div class="d-flex align-items-center gap-2">
                        <!-- CART BUTTON -->
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-warning btn-sm position-relative me-2">
                            <i class="bi bi-cart-fill me-1"></i>Giỏ Hàng
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${sessionScope.cartTotalItems != null ? sessionScope.cartTotalItems : 0}
                            </span>
                        </a>

                        <c:choose>
                            <c:when test="${empty sessionScope.account}">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm">
                                    <i class="bi bi-box-arrow-in-right me-1"></i>Đăng Nhập
                                </a>
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm">
                                    <i class="bi bi-person-plus-fill me-1"></i>Đăng Ký
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="text-white me-2">
                                    <i class="bi bi-person-circle me-1"></i>${sessionScope.account.fullname}
                                </span>
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                                    <i class="bi bi-box-arrow-right me-1"></i>Đăng Xuất
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <!-- BODY CONTENT -->
    <main class="main-content py-4 container">
        <decorator:body/>
    </main>

    <!-- FOOTER -->
    <footer class="py-3 border-top">
        <div class="container text-center">
            <div class="row align-items-center">
                <div class="col-md-4 text-md-start">
                    <strong>Môn Lập Trình Web</strong> - Đề số 04
                </div>
                <div class="col-md-4 text-center">
                    <span class="badge bg-primary fs-6">MSSV: 24162042</span>
                </div>
                <div class="col-md-4 text-md-end">
                    <strong>Họ tên:</strong> Kim Gia Huy | <strong>Mã đề:</strong> 04
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

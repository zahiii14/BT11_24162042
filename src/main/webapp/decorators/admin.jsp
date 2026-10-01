<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><decorator:title default="Trang Quản Trị Admin - 24162042"/></title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { min-height: 100vh; display: flex; flex-direction: column; background-color: #f4f6f9; }
        .main-content { flex: 1; }
        footer { background-color: #1a252f; color: white; margin-top: auto; }
        .admin-sidebar { background-color: #2c3e50; min-height: 100%; color: white; }
    </style>
    <decorator:head/>
</head>
<body>

    <!-- ADMIN HEADER MENU -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
            <div class="container-fluid px-4">
                <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/admin/users">
                    <i class="bi bi-shield-lock-fill me-2"></i>ADMIN DASHBOARD - 24162042
                </a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/home" target="_blank">
                                <i class="bi bi-globe me-1"></i>Xem Trang Chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active text-warning" href="${pageContext.request.contextPath}/admin/users">
                                <i class="bi bi-people-fill me-1"></i>Quản Lý Users (Câu 3)
                            </a>
                        </li>
                    </ul>
                    <div class="d-flex align-items-center gap-2 text-white">
                        <span class="me-2"><i class="bi bi-person-badge-fill me-1"></i>Admin: ${sessionScope.account.fullname}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                            <i class="bi bi-box-arrow-right me-1"></i>Đăng Xuất
                        </a>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <!-- ADMIN BODY CONTENT -->
    <main class="main-content py-4 container-fluid px-4">
        <decorator:body/>
    </main>

    <!-- ADMIN FOOTER -->
    <footer class="py-3 border-top">
        <div class="container-fluid px-4 text-center">
            <div class="row align-items-center">
                <div class="col-md-4 text-md-start">
                    <strong>Hệ Thống Quản Trị Web</strong> - Đề số 04
                </div>
                <div class="col-md-4 text-center">
                    <span class="badge bg-warning text-dark fs-6">MSSV: 24162042</span>
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

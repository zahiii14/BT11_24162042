<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ - Video Portal 24162042</title>
</head>
<body>

    <div class="p-5 mb-4 bg-light rounded-3 border shadow-sm">
        <div class="container-fluid py-3 text-center">
            <h1 class="display-5 fw-bold text-primary">Hệ Thống Quản Lý Video & Thành Viên</h1>
            <p class="col-md-10 fs-4 mx-auto text-muted">
                Bài Thi Quá Trình Môn Lập Trình Web - Đề số 04 - MSSV: <strong>24162042</strong>
            </p>
            <div class="d-flex justify-content-center gap-3 mt-4">
                <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/videos">
                    <i class="bi bi-grid-fill me-2"></i>Xem Phim theo Category (Câu 5 & 6)
                </a>
                <a class="btn btn-outline-secondary btn-lg" href="${pageContext.request.contextPath}/video/detail?id=V01">
                    <i class="bi bi-play-circle-fill me-2"></i>Xem Chi Tiết Video (Câu 4)
                </a>
            </div>
        </div>
    </div>

    <!-- Danh mục danh mục -->
    <h3 class="fw-bold mb-3 border-start border-4 border-primary ps-2">Danh Mục Thể Loại (Categories)</h3>
    <div class="row g-4 mb-5">
        <c:forEach var="cat" items="${categories}">
            <div class="col-md-3">
                <div class="card h-100 shadow-sm border-0">
                    <img src="${cat.images}" class="card-img-top" alt="${cat.categoryname}" style="height: 160px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h5 class="card-title fw-bold">${cat.categoryname}</h5>
                        <p class="text-muted mb-2">Số lượng: <span class="badge bg-info text-dark">${cat.videoCount} video</span></p>
                        <a href="${pageContext.request.contextPath}/videos?categoryId=${cat.categoryId}" class="btn btn-sm btn-outline-primary w-100">
                            Khám Phá
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

</body>
</html>

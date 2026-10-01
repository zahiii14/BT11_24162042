<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Video Theo Danh Mục - 24162042</title>
</head>
<body>

<div class="card shadow-sm border-0 mb-4">
    <div class="card-body">
        <h5 class="fw-bold mb-3"><i class="bi bi-tags-fill me-2 text-primary"></i>Chọn Danh Mục (Category):</h5>
        <div class="d-flex flex-wrap gap-2">
            <c:forEach var="cat" items="${categories}">
                <a href="${pageContext.request.contextPath}/videos?categoryId=${cat.categoryId}" 
                   class="btn ${cat.categoryId == categoryId ? 'btn-primary' : 'btn-outline-primary'} rounded-pill">
                   ${cat.categoryname} <strong>(${cat.videoCount})</strong>
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Header Category Name (Count) - Câu 5 & Câu 6 -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold text-dark border-start border-4 border-primary ps-3 mb-0">
        ${currentCategory.categoryname} <span class="text-primary">(${totalVideos})</span>
    </h2>
    <span class="badge bg-secondary">Phân trang: 3 video / trang</span>
</div>

<!-- Grid 3 videos per page (Câu 5) -->
<div class="row g-4 mb-4">
    <c:forEach var="v" items="${videoList}">
        <div class="col-md-4">
            <div class="card h-100 shadow border-0 rounded-3 overflow-hidden">
                <div class="position-relative">
                    <img src="${v.poster}" class="card-img-top" alt="${v.title}" style="height: 200px; object-fit: cover;">
                    <span class="position-absolute bottom-0 start-0 bg-dark text-white px-2 py-1 small opacity-75">[poster]</span>
                </div>
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title fw-bold text-truncate" title="${v.title}">${v.title}</h5>
                    <div class="mb-2 text-muted small">
                        <div><strong>Mã video:</strong> <span class="text-danger fw-bold">${v.videoId}</span></div>
                        <div><strong>Category name:</strong> ${v.categoryName}</div>
                        <div><strong>Giá bán:</strong> <span class="text-danger fw-bold fs-6"><fmt:formatNumber value="${v.price}" type="currency" currencySymbol="₫"/></span></div>
                        <div><strong>View:</strong> <span class="text-success fw-bold">${v.views}</span></div>
                    </div>
                    
                    <div class="d-flex gap-2 mb-3 mt-auto">
                        <a href="${pageContext.request.contextPath}/cart/add?id=${v.videoId}&quantity=1" class="btn btn-warning btn-sm flex-fill fw-bold shadow-sm">
                            <i class="bi bi-cart-plus-fill me-1"></i>Thêm Giỏ Hàng
                        </a>
                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="btn btn-outline-primary btn-sm flex-fill fw-bold">
                            <i class="bi bi-play-circle me-1"></i>Chi Tiết
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <c:if test="${empty videoList}">
        <div class="col-12">
            <div class="alert alert-info text-center py-4">
                <i class="bi bi-info-circle fs-3 d-block mb-2"></i>
                Không có video nào trong danh mục này!
            </div>
        </div>
    </c:if>
</div>

<!-- Pagination << 1 2 3 4 5 >> (Câu 5) -->
<c:if test="${totalPages > 1}">
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${categoryId}&page=${currentPage - 1}">&lt;&lt;</a>
            </li>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${categoryId}&page=${i}">${i}</a>
                </li>
            </c:forEach>

            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/videos?categoryId=${categoryId}&page=${currentPage + 1}">&gt;&gt;</a>
            </li>
        </ul>
    </nav>
</c:if>

</body>
</html>

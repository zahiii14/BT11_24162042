<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Video - ${video.title}</title>
</head>
<body>

<div class="card shadow border-0 rounded-3 overflow-hidden my-3">
    <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
        <h5 class="mb-0 fw-bold"><i class="bi bi-play-circle-fill me-2 text-danger"></i>Chi Tiết Video (Câu 4)</h5>
        <span class="badge bg-secondary">MSSV: 24162042</span>
    </div>
    <div class="card-body p-4">
        <div class="row">
            <!-- Left: Poster image -->
            <div class="col-md-5 mb-3 mb-md-0">
                <div class="position-relative overflow-hidden rounded-3 border shadow-sm">
                    <img src="${video.poster}" class="img-fluid w-100" alt="${video.title}" style="max-height: 320px; object-fit: cover;">
                    <div class="position-absolute bottom-0 start-0 w-100 p-2 bg-dark bg-opacity-75 text-white text-center">
                        <i class="bi bi-image me-1"></i>[poster]
                    </div>
                </div>
            </div>

            <!-- Right: Video Info -->
            <div class="col-md-7">
                <h3 class="fw-bold text-primary mb-3">${video.title}</h3>

                <ul class="list-group list-group-flush fs-5 mb-3">
                    <li class="list-group-item px-0">
                        <strong class="text-dark">Mã video/sản phẩm:</strong> 
                        <span class="text-danger fw-bold">${video.videoId}</span>
                    </li>
                    <li class="list-group-item px-0">
                        <strong class="text-dark">Category name:</strong> 
                        <span class="badge bg-info text-dark">${video.categoryName}</span>
                    </li>
                    <li class="list-group-item px-0">
                        <strong class="text-dark">Giá bán:</strong> 
                        <span class="text-danger fs-4 fw-bold">
                            <fmt:formatNumber value="${video.price}" type="currency" currencySymbol="₫"/>
                        </span>
                    </li>
                    <li class="list-group-item px-0">
                        <strong class="text-dark">Lượt xem:</strong> 
                        <span class="text-success fw-bold"><i class="bi bi-eye-fill me-1"></i>${video.views}</span>
                    </li>
                </ul>

                <!-- Add to Cart Form -->
                <form action="${pageContext.request.contextPath}/cart/add" method="get" class="d-flex align-items-center gap-2 mb-3">
                    <input type="hidden" name="id" value="${video.videoId}"/>
                    <div class="input-group" style="width: 140px;">
                        <span class="input-group-text bg-light fw-bold">SL</span>
                        <input type="number" name="quantity" class="form-control text-center fw-bold" value="1" min="1" max="99" required/>
                    </div>
                    <button type="submit" class="btn btn-warning btn-lg fw-bold flex-fill shadow-sm">
                        <i class="bi bi-cart-plus-fill me-2"></i>Thêm Vào Giỏ Hàng
                    </button>
                </form>

                <div class="d-flex gap-2 mb-3">
                    <button class="btn btn-sm btn-outline-primary px-3">
                        <i class="bi bi-share-fill me-1"></i>Share(<strong class="text-danger">${video.shareCount}</strong>)
                    </button>
                    <button class="btn btn-sm btn-outline-danger px-3">
                        <i class="bi bi-heart-fill me-1"></i>Like(<strong class="text-danger">${video.likeCount}</strong>)
                    </button>
                </div>

                <div class="mt-4 p-3 bg-light rounded border">
                    <h6 class="fw-bold text-secondary mb-2"><i class="bi bi-card-text me-1"></i>Description:</h6>
                    <p class="mb-0 text-dark fs-6">${video.description}</p>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

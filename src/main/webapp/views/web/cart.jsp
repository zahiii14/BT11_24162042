<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng Của Bạn - 24162042</title>
</head>
<body>

<div class="card shadow-sm border-0 rounded-3 my-3">
    <div class="card-header bg-primary text-white py-3 d-flex justify-content-between align-items-center">
        <h4 class="mb-0 fw-bold"><i class="bi bi-cart-fill me-2"></i>GIỎ HÀNG CỦA BẠN</h4>
        <a href="${pageContext.request.contextPath}/videos" class="btn btn-outline-light btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Tiếp tục mua hàng
        </a>
    </div>

    <div class="card-body p-4">
        <c:choose>
            <c:when test="${empty sessionScope.cart}">
                <div class="text-center py-5">
                    <i class="bi bi-cart-x text-muted display-1 d-block mb-3"></i>
                    <h4 class="text-muted fw-bold">Giỏ hàng của bạn đang trống!</h4>
                    <p class="text-secondary">Hãy khám phá các sản phẩm/video tuyệt vời và thêm vào giỏ hàng ngay.</p>
                    <a href="${pageContext.request.contextPath}/videos" class="btn btn-primary btn-lg fw-bold mt-2">
                        <i class="bi bi-grid-fill me-2"></i>Xem Danh Sách Sản Phẩm
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 100px;">Hình ảnh</th>
                                <th>Mã & Tên Sản Phẩm</th>
                                <th class="text-end" style="width: 140px;">Đơn giá</th>
                                <th class="text-center" style="width: 160px;">Số lượng (1 - 99)</th>
                                <th class="text-end" style="width: 160px;">Thành tiền</th>
                                <th class="text-center" style="width: 80px;">Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${sessionScope.cart}">
                                <tr>
                                    <td>
                                        <img src="${item.video.poster}" class="rounded border" width="80" height="50" style="object-fit: cover;" alt="${item.video.title}">
                                    </td>
                                    <td>
                                        <div class="fw-bold text-primary">${item.video.title}</div>
                                        <small class="text-muted">Mã: <span class="text-danger fw-bold">${item.video.videoId}</span> | Danh mục: ${item.video.categoryName}</small>
                                    </td>
                                    <td class="text-end fw-semibold">
                                        <fmt:formatNumber value="${item.video.price}" type="currency" currencySymbol="₫"/>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-flex justify-content-center">
                                            <input type="hidden" name="id" value="${item.video.videoId}"/>
                                            <div class="input-group input-group-sm" style="max-width: 130px;">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="99" 
                                                       class="form-control text-center fw-bold" onchange="this.form.submit()"/>
                                                <button type="submit" class="btn btn-outline-secondary" title="Cập nhật số lượng">
                                                    <i class="bi bi-arrow-clockwise"></i>
                                                </button>
                                            </div>
                                        </form>
                                    </td>
                                    <td class="text-end fw-bold text-danger fs-6">
                                        <fmt:formatNumber value="${item.amount}" type="currency" currencySymbol="₫"/>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/cart/delete?id=${item.video.videoId}" 
                                           class="btn btn-outline-danger btn-sm" title="Xóa khỏi giỏ hàng"
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                            <i class="bi bi-trash-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="row align-items-center mt-4 pt-3 border-top">
                    <div class="col-md-6 mb-3 mb-md-0">
                        <a href="${pageContext.request.contextPath}/cart/clear" class="btn btn-outline-danger btn-sm"
                           onclick="return confirm('Bạn có chắc muốn xóa toàn bộ sản phẩm trong giỏ hàng?');">
                            <i class="bi bi-trash me-1"></i>Xóa Sạch Giỏ Hàng
                        </a>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <div class="fs-5 mb-2">
                            Tổng tiền thanh toán (<strong class="text-primary">${sessionScope.cartTotalItems}</strong> sản phẩm):
                            <span class="fs-3 fw-bold text-danger ms-2">
                                <fmt:formatNumber value="${sessionScope.cartTotalAmount}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>
                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success btn-lg fw-bold px-4 shadow">
                            <i class="bi bi-credit-card-fill me-2"></i>Tiến Hành Thanh Toán (COD)
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>

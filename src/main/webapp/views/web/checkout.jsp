<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh Toán Đơn Hàng COD - 24162042</title>
</head>
<body>

<div class="row justify-content-center my-3">
    <div class="col-lg-8">
        <div class="card shadow border-0 rounded-3">
            <div class="card-header bg-success text-white py-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0 fw-bold"><i class="bi bi-truck me-2"></i>THANH TOÁN ĐƠN HÀNG (COD)</h4>
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-cart-fill me-1"></i>Quay lại giỏ hàng
                </a>
            </div>

            <div class="card-body p-4">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/checkout" method="post">
                    <!-- SECTION 1: RECEIVER INFORMATION -->
                    <h5 class="fw-bold text-primary mb-3 border-bottom pb-2">
                        <i class="bi bi-geo-alt-fill me-2"></i>Thông Tin Người Nhận Hàng
                    </h5>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="fullname" class="form-label fw-semibold">Họ và Tên người nhận *</label>
                            <input type="text" class="form-control" id="fullname" name="fullname" 
                                   value="${account != null ? account.fullname : 'Nguyễn Văn A'}" required>
                        </div>
                        <div class="col-md-6">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại *</label>
                            <input type="text" class="form-control" id="phone" name="phone" 
                                   value="${account != null ? account.phone : '0912345678'}" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label fw-semibold">Địa chỉ giao hàng chi tiết *</label>
                        <input type="text" class="form-control" id="address" name="address" 
                               placeholder="Ví dụ: 123 Lê Văn Việt, Phường Tăng Nhơn Phú A, TP. Thủ Đức, TP.HCM" required>
                    </div>

                    <div class="mb-4">
                        <label for="note" class="form-label fw-semibold">Ghi chú giao hàng</label>
                        <textarea class="form-control" id="note" name="note" rows="2" 
                                  placeholder="Ghi chú thêm (vd: Giao giờ hành chính, gọi trước khi giao...)"></textarea>
                    </div>

                    <!-- SECTION 2: PAYMENT METHOD -->
                    <h5 class="fw-bold text-primary mb-3 border-bottom pb-2">
                        <i class="bi bi-cash-stack me-2"></i>Phương Thức Thanh Toán
                    </h5>

                    <div class="p-3 bg-light rounded border mb-4">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                            <label class="form-check-label fw-bold text-dark fs-6" for="cod">
                                <i class="bi bi-truck text-success me-2 fs-5"></i>Thanh toán khi nhận hàng (COD - Cash On Delivery)
                            </label>
                            <div class="text-muted small ms-4 mt-1">
                                Bạn sẽ thanh toán trực tiếp bằng tiền mặt cho nhân viên giao hàng khi nhận được đơn hàng.
                            </div>
                        </div>
                    </div>

                    <!-- SECTION 3: ORDER SUMMARY -->
                    <h5 class="fw-bold text-primary mb-3 border-bottom pb-2">
                        <i class="bi bi-bag-check-fill me-2"></i>Tóm Tắt Đơn Hàng (${sessionScope.cartTotalItems} sản phẩm)
                    </h5>

                    <div class="table-responsive mb-3">
                        <table class="table table-sm align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th class="text-center">Số lượng</th>
                                    <th class="text-end">Đơn giá</th>
                                    <th class="text-end">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${sessionScope.cart}">
                                    <tr>
                                        <td>
                                            <strong>${item.video.title}</strong>
                                            <span class="text-muted small">(${item.video.videoId})</span>
                                        </td>
                                        <td class="text-center fw-bold">${item.quantity}</td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${item.video.price}" type="currency" currencySymbol="₫"/>
                                        </td>
                                        <td class="text-end fw-bold">
                                            <fmt:formatNumber value="${item.amount}" type="currency" currencySymbol="₫"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="card bg-light border-0 p-3 mb-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fs-5 fw-bold">TỔNG THÀNH TIỀN:</span>
                            <span class="fs-3 fw-bold text-danger">
                                <fmt:formatNumber value="${sessionScope.cartTotalAmount}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success btn-lg w-100 py-3 fw-bold shadow">
                        <i class="bi bi-check-circle-fill me-2"></i>XÁC NHẬN ĐẶT HÀNG BẰNG COD
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>

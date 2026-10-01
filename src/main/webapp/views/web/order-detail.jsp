<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Đơn Hàng #${order.orderId} - 24162042</title>
</head>
<body>

<div class="row justify-content-center my-3">
    <div class="col-lg-9">
        <c:if test="${not empty sessionScope.checkoutSuccess}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <h5 class="fw-bold mb-1"><i class="bi bi-check-circle-fill me-2"></i>${sessionScope.checkoutSuccess}</h5>
                Cảm ơn bạn đã đặt hàng. Đơn hàng của bạn đang ở trạng thái <strong>"Đơn hàng mới"</strong> và sẽ sớm được xử lý!
                <button type="button" class="btn-close" data-bs-dismiss="alert" onclick="<% session.removeAttribute("checkoutSuccess"); %>"></button>
            </div>
        </c:if>

        <div class="card shadow border-0 rounded-3">
            <div class="card-header bg-primary text-white py-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0 fw-bold">
                    <i class="bi bi-receipt me-2"></i>CHI TIẾT ĐƠN HÀNG #${order.orderId}
                </h4>
                <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách đơn
                </a>
            </div>

            <div class="card-body p-4">
                <!-- ORDER HEADER INFO -->
                <div class="row mb-4 bg-light p-3 rounded border align-items-center">
                    <div class="col-md-6 mb-2 mb-md-0">
                        <div><strong>Mã đơn hàng:</strong> <span class="fs-5 text-primary fw-bold">#${order.orderId}</span></div>
                        <div>
                            <strong>Ngày đặt:</strong> 
                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </div>
                        <div><strong>Phương thức thanh toán:</strong> <span class="badge bg-secondary">${order.paymentMethod}</span></div>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <div class="mb-1"><strong>Trạng thái đơn hàng:</strong></div>
                        <span class="badge ${order.statusBadgeClass} fs-5 px-4 py-2">
                            <i class="bi bi-tag-fill me-1"></i>${order.status}
                        </span>
                    </div>
                </div>

                <!-- RECEIVER INFO -->
                <h5 class="fw-bold text-dark mb-3 border-bottom pb-2">
                    <i class="bi bi-geo-alt-fill me-2 text-danger"></i>Thông Tin Giao Hàng
                </h5>
                <ul class="list-group list-group-flush mb-4">
                    <li class="list-group-item px-0"><strong>Người nhận:</strong> ${order.fullname}</li>
                    <li class="list-group-item px-0"><strong>Số điện thoại:</strong> ${order.phone}</li>
                    <li class="list-group-item px-0"><strong>Địa chỉ giao:</strong> ${order.address}</li>
                    <c:if test="${not empty order.note}">
                        <li class="list-group-item px-0"><strong>Ghi chú:</strong> ${order.note}</li>
                    </c:if>
                </ul>

                <!-- ORDER ITEMS -->
                <h5 class="fw-bold text-dark mb-3 border-bottom pb-2">
                    <i class="bi bi-basket-fill me-2 text-warning"></i>Danh Sách Sản Phẩm Trong Đơn
                </h5>

                <div class="table-responsive mb-4">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 80px;">Hình ảnh</th>
                                <th>Sản phẩm / Video</th>
                                <th class="text-end">Đơn giá</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-end">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dt" items="${order.details}">
                                <tr>
                                    <td>
                                        <img src="${dt.video != null ? dt.video.poster : 'https://picsum.photos/100/60'}" 
                                             class="rounded border" width="70" height="45" style="object-fit: cover;">
                                    </td>
                                    <td>
                                        <div class="fw-bold text-primary">${dt.video != null ? dt.video.title : dt.videoId}</div>
                                        <small class="text-muted">Mã: ${dt.videoId}</small>
                                    </td>
                                    <td class="text-end">
                                        <fmt:formatNumber value="${dt.price}" type="currency" currencySymbol="₫"/>
                                    </td>
                                    <td class="text-center fw-bold">${dt.quantity}</td>
                                    <td class="text-end fw-bold text-danger">
                                        <fmt:formatNumber value="${dt.amount}" type="currency" currencySymbol="₫"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- TOTAL & ACTIONS -->
                <div class="d-flex justify-content-between align-items-center bg-light p-3 rounded border mb-4">
                    <div>
                        <c:if test="${order.status == 'Đơn hàng mới'}">
                            <a href="${pageContext.request.contextPath}/order-cancel?id=${order.orderId}" 
                               class="btn btn-danger fw-bold"
                               onclick="return confirm('Bạn có chắc chắn muốn HỦY đơn hàng này không?');">
                                <i class="bi bi-x-circle-fill me-1"></i>Hủy Đơn Hàng Này
                            </a>
                        </c:if>
                    </div>
                    <div class="text-end">
                        <span class="fs-5 fw-bold">Tổng thanh toán:</span>
                        <span class="fs-3 fw-bold text-danger ms-2">
                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                        </span>
                    </div>
                </div>

                <!-- SIMULATOR FOR CHANGING STATUS -->
                <div class="p-3 bg-white rounded border">
                    <h6 class="fw-bold text-secondary mb-2">
                        <i class="bi bi-sliders me-1"></i>Công cụ đổi trạng thái nhanh trong Database:
                    </h6>
                    <form action="${pageContext.request.contextPath}/admin/order/update-status" method="get" class="row g-2 align-items-center">
                        <input type="hidden" name="id" value="${order.orderId}"/>
                        <div class="col-auto">
                            <select name="status" class="form-select">
                                <c:forEach var="st" items="${allStatuses}">
                                    <option value="${st}" ${order.status == st ? 'selected' : ''}>${st}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary fw-bold">
                                <i class="bi bi-arrow-repeat me-1"></i>Cập Nhật Trạng Thái Trực Tiếp
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>

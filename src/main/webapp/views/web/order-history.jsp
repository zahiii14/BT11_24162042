<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đặt Hàng - 24162042</title>
    <style>
        .nav-pills .nav-link { font-weight: 600; color: #495057; border-radius: 20px; padding: 6px 16px; }
        .nav-pills .nav-link.active { background-color: #0d6efd; color: white; }
    </style>
</head>
<body>

<div class="card shadow-sm border-0 rounded-3 my-3">
    <div class="card-header bg-dark text-white py-3 d-flex justify-content-between align-items-center">
        <h4 class="mb-0 fw-bold">
            <i class="bi bi-clock-history me-2 text-warning"></i>LỊCH SỬ ĐẶT HÀNG (Tài khoản: <span class="text-info">${currentUsername}</span>)
        </h4>
        <span class="badge bg-warning text-dark fs-6">MSSV: 24162042</span>
    </div>

    <div class="card-body p-4">

        <c:if test="${not empty sessionScope.orderMsg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>${sessionScope.orderMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" onclick="<% session.removeAttribute("orderMsg"); %>"></button>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.orderError}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${sessionScope.orderError}
                <button type="button" class="btn-close" data-bs-dismiss="alert" onclick="<% session.removeAttribute("orderError"); %>"></button>
            </div>
        </c:if>

        <!-- 8 ORDER STATUS FILTER TABS -->
        <h6 class="fw-bold text-secondary mb-3">
            <i class="bi bi-funnel-fill me-1"></i>Lọc theo trạng thái đơn hàng (8 trạng thái):
        </h6>

        <div class="d-flex flex-wrap gap-2 mb-4 p-2 bg-light rounded border">
            <a href="${pageContext.request.contextPath}/my-orders?status=ALL" 
               class="btn btn-sm ${selectedStatus == 'ALL' ? 'btn-primary' : 'btn-outline-secondary'} rounded-pill">
                Tất cả <span class="badge bg-light text-dark ms-1">${statusCounts['ALL']}</span>
            </a>

            <c:forEach var="st" items="${allStatuses}">
                <c:set var="btnClass" value="btn-outline-secondary" />
                <c:if test="${selectedStatus == st}">
                    <c:set var="btnClass" value="btn-primary" />
                </c:if>
                <a href="${pageContext.request.contextPath}/my-orders?status=${st}" 
                   class="btn btn-sm ${btnClass} rounded-pill">
                    ${st} <span class="badge ${selectedStatus == st ? 'bg-light text-dark' : 'bg-secondary'} ms-1">${statusCounts[st]}</span>
                </a>
            </c:forEach>
        </div>

        <!-- ORDERS LIST -->
        <c:choose>
            <c:when test="${empty orders}">
                <div class="alert alert-info text-center py-4 rounded-3">
                    <i class="bi bi-inbox fs-2 d-block mb-2 text-muted"></i>
                    Không tìm thấy đơn hàng nào ở trạng thái <strong>"${selectedStatus == 'ALL' ? 'Tất cả' : selectedStatus}"</strong>!
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="ord" items="${orders}">
                        <div class="col-12">
                            <div class="card border shadow-sm rounded-3 overflow-hidden">
                                <div class="card-header bg-light d-flex justify-content-between align-items-center py-3">
                                    <div>
                                        <strong class="fs-5 text-primary">Mã đơn hàng: #${ord.orderId}</strong>
                                        <span class="text-muted ms-3 small">
                                            <i class="bi bi-calendar3 me-1"></i>
                                            <fmt:formatDate value="${ord.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                        </span>
                                    </div>
                                    <div>
                                        <!-- Status Badge -->
                                        <span class="badge ${ord.statusBadgeClass} fs-6 px-3 py-2">
                                            <i class="bi bi-tag-fill me-1"></i>${ord.status}
                                        </span>
                                    </div>
                                </div>

                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-md-7 mb-3 mb-md-0">
                                            <div><strong>Người nhận:</strong> ${ord.fullname} - ${ord.phone}</div>
                                            <div class="text-truncate" style="max-width: 500px;">
                                                <strong>Địa chỉ:</strong> ${ord.address}
                                            </div>
                                            <div><strong>Phương thức thanh toán:</strong> <span class="badge bg-secondary">${ord.paymentMethod}</span></div>
                                            <c:if test="${not empty ord.note}">
                                                <div class="text-muted small"><strong>Ghi chú:</strong> ${ord.note}</div>
                                            </c:if>
                                        </div>
                                        <div class="col-md-5 text-md-end">
                                            <div class="mb-2">
                                                Tổng tiền: 
                                                <span class="fs-4 fw-bold text-danger">
                                                    <fmt:formatNumber value="${ord.totalAmount}" type="currency" currencySymbol="₫"/>
                                                </span>
                                            </div>

                                            <div class="d-flex justify-content-md-end gap-2 align-items-center">
                                                <a href="${pageContext.request.contextPath}/order-detail?id=${ord.orderId}" class="btn btn-outline-primary btn-sm fw-bold">
                                                    <i class="bi bi-eye-fill me-1"></i>Xem Chi Tiết
                                                </a>

                                                <!-- CANCEL ORDER BUTTON (only allowed if Status is 'Đơn hàng mới') -->
                                                <c:if test="${ord.status == 'Đơn hàng mới'}">
                                                    <a href="${pageContext.request.contextPath}/order-cancel?id=${ord.orderId}" 
                                                       class="btn btn-danger btn-sm fw-bold"
                                                       onclick="return confirm('Bạn có chắc chắn muốn HỦY đơn hàng #${ord.orderId} không?');">
                                                        <i class="bi bi-x-circle-fill me-1"></i>Hủy Đơn Hàng
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- SIMULATED STATUS CHANGE TOOL FOR TESTING (As requested by lab prompt) -->
                                    <div class="mt-3 pt-2 border-top bg-light p-2 rounded">
                                        <form action="${pageContext.request.contextPath}/admin/order/update-status" method="get" class="row g-2 align-items-center">
                                            <input type="hidden" name="id" value="${ord.orderId}"/>
                                            <input type="hidden" name="currentFilter" value="${selectedStatus}"/>
                                            <div class="col-auto">
                                                <span class="badge bg-dark small">
                                                    <i class="bi bi-gear-fill me-1"></i>Mô phỏng đổi trạng thái DB:
                                                </span>
                                            </div>
                                            <div class="col-auto">
                                                <select name="status" class="form-select form-select-sm">
                                                    <c:forEach var="st" items="${allStatuses}">
                                                        <option value="${st}" ${ord.status == st ? 'selected' : ''}>${st}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-auto">
                                                <button type="submit" class="btn btn-sm btn-outline-secondary">
                                                    Cập Nhật Trạng Thái
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>

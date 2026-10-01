<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Users - Admin 24162042</title>
</head>
<body>

<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
        <h4 class="mb-0 fw-bold text-primary">
            <i class="bi bi-people-fill me-2"></i>Quản Lý Dữ Liệu Bảng Users (Câu 3)
        </h4>
        <a href="${pageContext.request.contextPath}/admin/user/add" class="btn btn-success fw-bold">
            <i class="bi bi-plus-circle-fill me-1"></i>Thêm User Mới
        </a>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th class="text-center">Avatar</th>
                        <th>Username</th>
                        <th>Họ và Tên</th>
                        <th>Email</th>
                        <th>Điện Thoại</th>
                        <th class="text-center">Vai Trò</th>
                        <th class="text-center">Trạng Thái</th>
                        <th class="text-center" style="width: 160px;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${userList}">
                        <tr>
                            <td class="text-center">
                                <img src="${empty u.images ? 'https://i.pravatar.cc/150' : u.images}" 
                                     class="rounded-circle border" width="40" height="40" alt="${u.username}">
                            </td>
                            <td class="fw-bold text-primary">${u.username}</td>
                            <td>${u.fullname}</td>
                            <td>${u.email}</td>
                            <td>${u.phone}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.admin}">
                                        <span class="badge bg-danger">Admin</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">User</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.active}">
                                        <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark"><i class="bi bi-clock me-1"></i>Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/user/edit?username=${u.username}" 
                                   class="btn btn-sm btn-primary me-1" title="Sửa">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/user/delete?username=${u.username}" 
                                   class="btn btn-sm btn-danger" title="Xóa"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa user [${u.username}] không?');">
                                    <i class="bi bi-trash-fill"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userList}">
                        <tr>
                            <td colspan="8" class="text-center py-4 text-muted">Không có dữ liệu user nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Footer Pagination 6 users per page -->
    <div class="card-footer bg-light d-flex justify-content-between align-items-center py-3">
        <div class="text-muted small">
            Hiển thị <strong>${userList.size()}</strong> / tổng <strong>${totalUsers}</strong> users (6 user/trang)
        </div>
        <c:if test="${totalPages > 1}">
            <nav aria-label="User Pagination">
                <ul class="pagination pagination-sm mb-0">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}">Trước</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

</body>
</html>

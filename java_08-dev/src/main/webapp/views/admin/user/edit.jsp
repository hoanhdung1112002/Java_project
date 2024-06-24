
<!DOCTYPE html>
<html lang="en">
    <%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
    <%@ include file="../layouts/head.jsp" %>
<body>
    <div id="main-wrapper">
        
        <%@ include file="../layouts/header.jsp" %>
        
        <%@ include file="../layouts/navbar.jsp" %>

        <!-- Content -->
        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Quản lý người dùng</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                        <li class="breadcrumb-item">Quản lý người dùng</li>
                        <li class="breadcrumb-item active">Cập nhật người dùng</li>
                    </ol>
                </nav>
            </div>
            
            <section class="section dashboard">
                <div class="card">
                    <div class="card-body p-3">

                        <c:if test="${not empty success}">
                            <div class="col-12">
                                <div class="alert alert-success">
                                    <c:out value="${success}" />
                                </div>
                            </div>
                        </c:if>

                        <form:form method="POST" modelAttribute="user" action="/admin/users/update/${user.getID()}" enctype="multipart/form-data" class="row needs-validation" id="form-create">
                            <div class="col-sm-6 mb-3">
                                <div class="form-floating mb-1">
                                    <form:input path="fullName" value="${user.getFullName()}"  type="text" class="form-control" placeholder="Họ và tên" />
                                    <label for="fullName">Họ và tên</label>
                                </div>
                                <form:errors path="fullName" cssClass="ms-1 text-danger"/>
                            </div>
                            
                            <div class="col-sm-6 mb-3">
                                <div class="form-floating mb-1">
                                    <form:input path="username" value="${user.getUsername()}" type="text" class="form-control" placeholder="Tài khoản" />
                                    <label for="username">Tài khoản</label>
                                </div>
                                <form:errors path="username" cssClass="ms-1 text-danger"/>
                            </div>
                            
                            <div class="col-sm-6 mb-3">
                                <div class="form-floating mb-1">
                                    <form:input path="phone" value="${user.getPhone()}" type="number" class="form-control" placeholder="Điện thoại" />
                                    <label for="phone">Điện thoại</label>
                                </div>
                                <form:errors path="phone" cssClass="ms-1 text-danger"/>
                            </div>
                            
                            <div class="col-sm-6 mb-3">
                                <div class="form-floating mb-1">
                                    <form:input path="email" value="${user.getEmail()}" type="text" class="form-control" placeholder="Email" />
                                    <label for="email">Email</label>
                                </div>
                                <form:errors path="email" cssClass="ms-1 text-danger"/>
                            </div>
        
                            <div class="col-sm-6 mb-3">
                                <div class="form-floating mb-1">
                                    <select path="role" class="form-select" name="role" id="role" aria-label="State">
                                        <option value="0">Quản trị viên</option>
                                        <option value="1" selected>Người dùng</option>
                                    </select>
                                    <label for="role">Vai trò</label>
                                </div>
                            </div>
        
                            <div class="col-sm-6 mb-3 d-flex align-items-center justify-content-center">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" checked="checked" name="gender" id="gtNam" value="1">
                                    <label class="form-check-label" for="gtNam">Nam</label>
                                </div>
                                <div class="form-check ms-3">
                                    <input class="form-check-input" type="radio" name="gender" id="gtNu" value="0">
                                    <label class="form-check-label" for="gtNu">Nữ</label>
                                </div>
                                <div class="form-check ms-3">
                                    <input class="form-check-input" type="radio" name="gender" id="gtOther" value="2">
                                    <label class="form-check-label" for="gtOther">Khác</label>
                                </div>
                            </div>
        
                            <div class="col-12">
                                <textarea type="text" class="form-control tinymce-editor" id="introduce" name="introduce" placeholder="Nhập tài khoản">${user.getIntroduce()}</textarea>
                            </div>

                            <c:if test="${not empty error}">
                                <div class="text-center mt-3 text-danger">
                                    <c:out value="${error}" />
                                </div>
                            </c:if>

                            <div class="col-12 mt-3 d-flex justify-content-between">
                                <a href="/admin/users" type="submit" class="btn btn-secondary">
                                    <i class="me-2 bi bi-arrow-left-circle"></i>
                                    Quay lại
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="me-2 bi bi-save"></i>
                                    Lưu lại
                                </button>
                            </div>
                        </form:form>
                    
                    </div>
                </div>
            </section>
        </main>

        <%@ include file="../layouts/footer.jsp" %>
    </div>

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>

    <!-- Vendor JS Files -->
    <script src="/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/vendor/chart.js/chart.min.js"></script>
    <script src="/vendor/echarts/echarts.min.js"></script>
    <script src="/vendor/quill/quill.min.js"></script>
    <script src="/vendor/tinymce/tinymce.min.js"></script>

    <!-- Template Main JS File -->
    <script src="/js/main.js"></script>
    <script src="/js/common.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

    <!-- Load Select2 JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
</body>
</html>
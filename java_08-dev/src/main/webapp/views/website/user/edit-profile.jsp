<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html class="no-js" lang="zxx">
    <%@ include file="../layouts/head.jsp" %>
   <body>

    <%@ include file="../layouts/header.jsp" %>

    <section class="blog_area single-post-area section-padding">
        <div class="container">
            <div class="row">
                <div class="col-xl-10 col-12 mx-auto">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="fs-18 mb-0 text-uppercase text-center">
                                HỒ SƠ Của tôi
                            </h5>
                            <p class="fs-14 text-center mb-3">Quản lý thông tin hồ sơ để bảo mật tài khoản</p>
                            <c:if test="${not empty success}">
                                <div class="w-100 mb-3">
                                    <div class="alert alert-success">
                                        <c:out value="${success}"/>
                                    </div>
                                </div>
                            </c:if>
                            <form:form method="POST" modelAttribute="user" action="/users/profile/update" enctype="multipart/form-data" class="row h-100">
                                <input type="hidden" name="ID" value="${user.ID}">
                                <input type="hidden" name="username" value="${user.username}">
                                <div class="col-12 col-md-4">
                                    <div class="d-flex flex-column align-items-center">
                                        <div style="width: 160px; height: 160px;">
                                            <c:set var="avatar" value="${authLogin.avatar}" />
                                            <c:choose>
                                                <c:when test="${empty avatar}">
                                                    <img class="rounded-circle avatar-image" id="img-account" src="/images/no-avatar.jpg" alt="avatar"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="rounded-circle avatar-image" id="img-account" src="/getImage/${avatar}" alt="avatar"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <label class="btn-line mt-3" for="_avatar">Chọn tệp</label>
                                        <input onchange="document.getElementById('img-account').src = window.URL.createObjectURL(this.files[0])"
                                            type="file" class="form-control-file d-none" name="_avatar" id="_avatar">
                                        <p class="fs-12 text-note mb-4 italic">Định dạng: .JPEG, .PNG</p>
                                    </div>
                                </div>

                                <div class="col-12 col-md-8">
                                    <div class="row">
                                        <div class="col-12 col-sm-6">
                                            <div class="form-group">
                                                <label for="title">Họ và tên</label>
                                                <form:input path="fullName" type="text" class="form-control" placeholder="Nhập họ và tên"/>
                                                <form:errors path="fullName" cssClass="ms-1 mt-2 text-danger"/>
                                            </div>
                                        </div>
                                        
                                        <div class="col-12 col-sm-6">
                                            <div class="form-group">
                                                <label for="title">Giới tính</label>
                                                 
                                                <div class="d-flex align-items-center justify-content-center" style="height: 38px; border: 1px solid #ced4da; border-radius: 0.25rem;">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" checked="checked" name="gender" id="gtNam" value="1">
                                                        <label class="form-check-label" for="gtNam">Nam</label>
                                                    </div>
                                                    <div class="form-check ml-3">
                                                        <input class="form-check-input" type="radio" name="gender" id="gtNu" value="0">
                                                        <label class="form-check-label" for="gtNu">Nữ</label>
                                                    </div>
                                                    <div class="form-check ml-3">
                                                        <input class="form-check-input" type="radio" name="gender" id="gtOther" value="2">
                                                        <label class="form-check-label" for="gtOther">Khác</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-12 col-sm-6">
                                            <div class="form-group">
                                                <label for="title">Địa chỉ email</label>
                                                <input value="${user.email}" name="email" id="email" type="email" class="form-control" readonly>
                                            </div>
                                        </div>

                                        <div class="col-12 col-sm-6">
                                            <div class="form-group">
                                                <label for="title">Số điện thoại</label>
                                                <form:input path="phone" type="text" class="form-control" placeholder="Nhập số điện thoại"/>
                                                <form:errors path="phone" cssClass="ms-1 mt-2 text-danger"/>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-group">
                                                <label for="title">Giới thiệu bản thân</label>
                                                <textarea class="tinymce-editor form-control" name="introduce" id="introduce" rows="5">${user.introduce}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty error}">
                                    <div class="col-12 text-center mt-3 text-danger">
                                        <c:out value="${error}" />
                                    </div>
                                </c:if>
                
                                <div class="col-12 d-flex justify-content-end">
                                    <button type="submit" class="btn button">
                                        Cập nhật
                                    </button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <%@ include file="../layouts/footer.jsp" %>
    </body>
</html>
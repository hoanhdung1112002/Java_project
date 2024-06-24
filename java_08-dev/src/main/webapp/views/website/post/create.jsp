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
                <div class="col-12 mx-auto">
                    <div class="card">
                        <div class="card-body">

                            <c:if test="${not empty success}">
                                <div class="w-100 mb-3">
                                    <div class="alert alert-success">
                                        <c:out value="${success}" />
                                    </div>
                                </div>
                            </c:if>
                            <form:form method="POST" modelAttribute="post" action="/posts/store" enctype="multipart/form-data" class="row h-100">
                                <div class="col-12">
                                    <div class="form-group">
                                        <label for="title">Tiêu đề bài viết</label>
                                        <input type="text" class="form-control" name="title" id="title" placeholder="Nhập tiêu đề">
                                        <form:errors path="title" cssClass="ms-1 mt-2 text-danger"/>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-group mb-3">
                                        <label for="_avatar">Ảnh đại diện</label>
                                        <input type="file" class="form-control-file" name="_avatar" id="_avatar">
                                    </div>
                                </div>
                                <div class="col-6">
                                    <label for="dm">Danh mục</label>
                                    <div class="form-select mb-3" id="default-select">
                                        <select name="categoryID" id="categoryID">
                                            <c:forEach var="item" items="${categories}">
                                                <option value="${item.ID}">${item.categoryName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-12 posts-list h-100 overflow-y-auto scroll-custom scroll-none">
                                    <textarea class="tinymce-editor form-control" name="content" id="content" cols="30" rows="10"></textarea>
                                </div>

                                <c:if test="${not empty error}">
                                    <div class="col-12 text-center mt-3 text-danger">
                                        <c:out value="${error}" />
                                    </div>
                                </c:if>

                                <div class="col-12 mt-3 d-flex justify-content-end">
                                    <button type="submit" class="btn button">
                                        Đăng bài viết
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

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
                <h1>Đăng bài viết mới</h1>
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

                        <form:form method="POST" modelAttribute="post" action="/admin/posts/store" enctype="multipart/form-data" class="row needs-validation" id="form-create">
                            <div class="col-12 mb-3">
                                <div class="form-floating mb-1">
                                    <form:input path="title" type="text" class="form-control" placeholder="Tiêu đề" />
                                    <label for="title">Tiêu đề bài viết</label>
                                </div>
                                <form:errors path="title" cssClass="ms-1 text-danger"/>
                            </div>

                            <div class="col-sm-6 mb-3">
                                <label for="role">Danh mục</label>
                                <form:select path="categoryID" class="form-select select2" aria-multiline="true">
                                    <c:forEach var="category" items="${categories}">
                                        <form:option value="${category.getID()}">
                                            ${category.getCategoryName()}
                                        </form:option>
                                    </c:forEach>
                                </form:select>
                            </div>

                            <div class="col-sm-6 mb-3">
                                <label for="_avatar">Ảnh đại diện</label>
                                <input name="_avatar" id="_avatar" type="file" accept="image/*" class="form-control"/>
                                <span id="_avatar.errors" class="ms-1 text-danger"></span>
                            </div>

                            <div class="col-12">
                                <textarea type="text" class="form-control tinymce-editor" id="content" name="content"></textarea>
                            </div>

                            <c:if test="${not empty error}">
                                <div class="text-center mt-3 text-danger">
                                    <c:out value="${error}" />
                                </div>
                            </c:if>

                            <div class="col-12 mt-3 d-flex justify-content-between">
                                <a href="/admin/posts" type="submit" class="btn btn-secondary">
                                    <i class="me-2 bi bi-arrow-left-circle"></i>
                                    Quay lại
                                </a>
                                <button type="submit" class="btn btn-primary">
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

    <script>
        $(".select2").select2({
            placeholder: 'Tìm kiếm',
            language: {
                noResults: function (params) {
                    return "Không tìm thấy kết quả";
                }
            },
        }).on('select2:open', function() {
            $('.select2-search__field').attr('maxlength', 50);
            $('.select2-search__field').attr('placeholder', 'Tìm kiếm');
        });
    </script>
</body>
</html>
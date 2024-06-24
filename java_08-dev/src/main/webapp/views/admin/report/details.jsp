
<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="en">

<%@ include file="../layouts/head.jsp" %>

<body>
    <div id="main-wrapper">

        <%@ include file="../layouts/header.jsp" %>

        <%@ include file="../layouts/navbar.jsp" %>

        <!-- Content -->
        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Bài viết bị báo cáo</h1>
            </div>

            <section class="section dashboard">
                <div class="card">
                    <div class="card-body p-3">
                        <div>
                            <strong>${report.userID.fullName}</strong>
                            báo cáo bài viết này <strong>${report.content}</strong> vào ngày
                            <fmt:formatDate value="${report.getCreatedAt()}" pattern="dd-MM-yyyy" /> lúc
                            <fmt:formatDate value="${report.getCreatedAt()}" pattern="HH:mm" />
                        </div>
                        <hr>
                        <div class="w-100" style="height: 60vh; overflow-y: auto;">
                            <h1 class="fw-bold">
                                ${report.postID.title}
                            </h1>
                            ${report.postID.content}
                        </div>
                        <div class="mt-3 d-flex justify-content-end">
                            <button data-id="${report.postID.ID}" class="btn btn-danger btn-min-80" id="btn-delete">
                                Gỡ bài viết
                            </button>
                            <button data-id="${report.ID}" class="ms-3 btn btn-primary btn-min-80" id="btn-giu">
                                Giữ bài viết
                            </button>
                        </div>
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
        //Handle delete
        $(document).on('click', '#btn-delete', function(e) {
            const id = $(this).data('id');

            Swal.fire({
                icon: 'question',
                text: `Xác nhận gỡ bài viết ?`,
                showCancelButton: true,
                confirmButtonText: 'Xác nhận',
                cancelButtonText: 'Hủy bỏ',
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: `/admin/posts/delete/` + id,
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                    }).done(function(response) {
                        showMessage("success", "Đã gỡ bài viết", () => location.href = "/admin/report/posts");
                    }).fail(function(xhr, status, error) {
                        showMessage("error");
                    });
                }
            });
        });

        // Giữ lại bài viết nhé
        $(document).on('click', '#btn-giu', function(e) {
            const id = $(this).data('id');

            Swal.fire({
                icon: 'question',
                text: `Xác nhận giữ bài viết ?`,
                showCancelButton: true,
                confirmButtonText: 'Xác nhận',
                cancelButtonText: 'Hủy bỏ',
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: `/admin/report/delete/` + id,
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                    }).done(function(response) {
                        showMessage("success", "Bài viết vẫn được giữ", () => location.href = "/admin/report/posts");
                    }).fail(function(xhr, status, error) {
                        showMessage("error");
                    });
                }
            });
        });
    </script>
</body>
</html>
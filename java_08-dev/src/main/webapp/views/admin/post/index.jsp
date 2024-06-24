
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
                <h1>Danh sách bài viết</h1>
            </div>

            <section class="section dashboard">
                <div class="card">
                    <div class="card-body p-3">

                        <div class="list-action d-flex mb-4">
                            <a class="btn btn-primary" href="/admin/posts/create">
                                Thêm mới
                            </a>
                        </div>

                        <table class="table data-tables">
                            <thead>
                                <tr>
                                    <th class="text-center">STT</th>
                                    <th class="text-center" width="500">Tiêu đề</th>
                                    <th class="text-center">Ngày đăng</th>
                                    <th class="text-center">Cập nhật cuối</th>
                                    <th class="text-center" data-sortable="false"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${posts.content}" varStatus="loopStatus">
                                    <tr id="post-${item.getID()}">
                                        <td class="text-center">${loopStatus.index + 1}</td>
                                        <td class="text-start">${item.getTitle()}</td>
                                        <td class="text-center">
                                            ${item.convertCreatedAt()}
                                        </td>
                                        <td class="text-center">
                                            <fmt:formatDate value="${item.getUpdateAt()}" pattern="dd-MM-yyyy HH:mm" />
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex align-items-center justify-content-center">
                                                <a class="btn btn-primary btn-min-80"
                                                    href="/admin/posts/edit/${item.getID()}">
                                                    Sửa
                                                </a>
                                                <button data-id="${item.getID()}" class="btn btn-danger btn-min-80 btn-delete-user">
                                                    Xóa
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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
        //Handle delete user
        $(document).on('click', '.btn-delete-user', function(e) {
            const id = $(this).data('id');

            Swal.fire({
                icon: 'question',
                text: `Xác nhận xóa bài viết ?`,
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
                        $(`#post-` + id).remove();
                        showMessage("success", "Bài viết đã xóa thành công");
                    }).fail(function(xhr, status, error) {
                        showMessage("error");
                    });
                }
            });
        });
    </script>
</body>
</html>
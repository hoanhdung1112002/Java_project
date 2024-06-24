
<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <%@ include file="../layouts/head.jsp" %>

<body>
    <div id="main-wrapper">

        <%@ include file="../layouts/header.jsp" %>

        <%@ include file="../layouts/navbar.jsp" %>

        <!-- Content -->
        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Thông báo đã gửi</h1>
            </div>

            <section class="section dashboard">
                <div class="card">
                    <div class="card-body p-3">

                        <div class="list-action d-flex mb-4">
                            <a href="/admin/notify/create" type="button" class="btn btn-primary">
                                Tạo thông báo
                            </a>
                        </div>

                        <table class="table table-borderless data-tables">
                            <thead>
                                <tr>
                                    <th class="text-center">STT</th>
                                    <th class="text-center">Tiêu đề</th>
                                    <th class="text-center">Nội dung</th>
                                    <th class="text-center">Thời gian gửi</th>
                                    <th class="text-center" data-sortable="false"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${notifications}" varStatus="loopStatus">
                                    <tr id="notify-${item.getID()}">
                                        <td class="text-center">${loopStatus.index + 1}</td>
                                        <td class="text-start">${item.title}</td>
                                        <td class="text-start">${item.content}</td>
                                        <td class="text-center">${item.convertCreatedAt()}</td>
                                        <td class="text-center">
                                            <div class="d-flex align-items-center justify-content-center">
                                                <a class="btn btn-primary btn-min-80"
                                                    href="/admin/notify/edit/${item.getID()}">
                                                    Sửa
                                                </a>
                                                <button data-id="${item.getID()}" class="btn btn-danger btn-min-80 btn-delete-notify">
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
        //Handle delete notify
        $(document).on('click', '.btn-delete-notify', function(e) {
            const id = $(this).data('id');

            Swal.fire({
                icon: 'question',
                text: `Xác nhận xóa thông báo ?`,
                showCancelButton: true,
                confirmButtonText: 'Xác nhận',
                cancelButtonText: 'Hủy bỏ',
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: `/admin/notify/delete/` + id,
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                    }).done(function(response) {
                        $(`#notify-` + id).remove();
                        showMessage("success", "Thông báo đã xóa thành công");
                    }).fail(function(xhr, status, error) {
                        showMessage("error");
                    });
                }
            });
        });
    </script>
</body>
</html>
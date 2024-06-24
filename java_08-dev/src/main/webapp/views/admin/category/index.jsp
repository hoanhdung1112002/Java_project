
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
                <h1>Danh sách danh mục</h1>
            </div>

            <section class="section dashboard">
                <div class="card">
                    <div class="card-body p-3">

                        <div class="list-action d-flex mb-4">
                            <a href="/admin/categories/create" type="button" class="btn btn-primary">
                                Thêm mới
                            </a>
                        </div>

                        <table class="table table-borderless data-tables">
                            <thead>
                                <tr>
                                    <th class="text-center">STT</th>
                                    <th class="text-center">Tên danh mục</th>
                                    <th class="text-center">Cấp danh mục</th>
                                    <th class="text-center" style="max-width: 136px;">Trạng thái</th>
                                    <th class="text-center" data-sortable="false"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${categories}" varStatus="loopStatus">
                                    <tr id="category-${item.getID()}">
                                        <td class="text-center">${loopStatus.index + 1}</td>
                                        <td class="text-start">${item.getCategoryName()}</td>
                                        <td class="text-center">Cấp ${item.getLevel()}</td>
                                        <td class="text-center" style="max-width: 136px;">
                                            <select class="form-select status" data-id="${item.getID()}">
                                                <option ${item.getStatus() eq 0 ? "selected" : ""} value="0">Đang ẩn</option>
                                                <option ${item.getStatus() eq 1 ? "selected" : ""} value="1">Hiển thị</option>
                                            </select>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex align-items-center justify-content-center">
                                                <a class="btn btn-primary btn-min-80"
                                                    href="/admin/categories/edit/${item.getID()}">
                                                    Sửa
                                                </a>
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
        // Change status
        $(document).on("change", ".status", function() {
            const id = $(this).data("id");
            const value = $(this).val();

            $.ajax({
                type: "POST",
                url: '/admin/categories/change-status',
                data: {
                    'id': id,
                    'value': value
                },
            }).done(function(response) {
                showMessage("success", "Thay đổi trạng thái thành công");
            }).fail(function(xhr, status, error) {
                showMessage("error");
            });
        });
    </script>
</body>
</html>
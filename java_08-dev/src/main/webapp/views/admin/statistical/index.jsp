
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
                <h1>Thống kê - báo cáo</h1>
            </div><!-- End Page Title -->
            <section class="section dashboard">
                <div class="row">
                    <!-- Left side columns -->
                    <div class="col-lg-8">
                        <div class="row">
                            <!-- Sales Card -->
                            <div class="col-xxl-4 col-md-6">
                                <div class="card info-card sales-card">
                                    <div class="card-body">
                                        <h5 class="card-title">Bài viết </h5>
                                        <div class="d-flex align-items-center">
                                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="bi bi-sticky"></i>
                                            </div>
                                            <div class="ps-3">
                                                <h6>${totalPost}</h6>
                                                <span class="text-muted small pt-2">bài viết</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End Sales Card -->
                            <!-- Revenue Card -->
                            <div class="col-xxl-4 col-md-6">
                                <div class="card info-card revenue-card">
                                    <div class="card-body">
                                        <h5 class="card-title">Câu trả lời </h5>
                                        <div class="d-flex align-items-center">
                                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="bi bi-chat-left-dots"></i>
                                            </div>
                                            <div class="ps-3">
                                                <h6>${totalComment}</h6>
                                                <span class="text-muted small pt-2">câu trả lời</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End Revenue Card -->
                            <!-- Customers Card -->
                            <div class="col-xxl-4 col-xl-12">
                                <div class="card info-card customers-card">
                                    <div class="card-body">
                                        <h5 class="card-title">Người dùng </h5>
                                        <div class="d-flex align-items-center">
                                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="bi bi-people"></i>
                                            </div>
                                            <div class="ps-3">
                                                <h6>${totalUser}</h6>
                                                <span class="text-muted small pt-2">người dùng</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End Customers Card -->
                            <!-- Reports -->
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body mb-0 pb-0">
                                    <h5 class="card-title">Xu hướng bài viết</h5>

                                    <!-- Pie Chart -->
                                    <div id="pieChart" style="min-height: 400px;" class="echart"></div>

                                    <script>
                                        document.addEventListener("DOMContentLoaded", () => {
                                        echarts.init(document.querySelector("#pieChart")).setOption({
                                            title: {
                                                // text: 'Xu hướng bài viết',
                                                // subtext: 'Fake Data',
                                                left: 'center'
                                            },
                                            tooltip: {
                                                trigger: 'item'
                                            },
                                            legend: {
                                                orient: 'vertical',
                                                left: 'left'
                                            },
                                            series: [{
                                                name: 'Tổng cộng',
                                                type: 'pie',
                                                radius: '50%',
                                                data: [
                                                    <c:forEach var="item" items="${categories}">
                                                        <c:set var="category" value="${item[0]}"/>
                                                        <c:set var="totalPost" value="${item[1]}"/>

                                                        {
                                                            value: ${totalPost},
                                                            name: '${category.categoryName}'
                                                        },
                                                    </c:forEach>
                                                ],
                                                emphasis: {
                                                    itemStyle: {
                                                        shadowBlur: 10,
                                                        shadowOffsetX: 0,
                                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                                    }
                                                }
                                            }]
                                        });
                                        });
                                    </script>
                                    <!-- End Pie Chart -->

                                    </div>
                                </div>
                            </div><!-- End Reports -->
                            <!-- Recent Sales -->
                            <div class="col-12">
                                <div class="card recent-sales overflow-auto">
                                    <div class="card-body">
                                        <h5 class="card-title">Top 5 bài viết nổi bật nhất </h5>
                                        <table class="table table-borderless datatable">
                                            <thead>
                                                <tr>
                                                    <th scope="col">ID</th>
                                                    <th scope="col" width="330">Tiêu đề</th>
                                                    <th scope="col">Tác giả</th>
                                                    <th scope="col">Xuất bản</th>
                                                    <th scope="col">Lượt thích</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${topPost}">
                                                    <tr>
                                                        <td scope="row"><a href="/posts/${item.getID()}/${item.getSlug()}.html">#${item.ID}</a></td>
                                                        <td>
                                                            <a href="/posts/${item.getID()}/${item.getSlug()}.html" class="text-primary">${item.title}</a>
                                                        </td>
                                                        <td>
                                                            ${item.getUserID().fullName == null or item.getUserID().fullName == '' ? item.getUserID().username : item.getUserID().fullName}
                                                        </td>
                                                        <td>
                                                            ${item.convertCreatedAt()}
                                                        </td>
                                                        <td class="text-center">
                                                            ${item.totalLike}
                                                            <i class="bi bi-balloon-heart"></i>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div><!-- End Recent Sales -->

                        </div>
                    </div><!-- End Left side columns -->
                    <!-- Right side columns -->
                    <div class="col-lg-4">
                        <!-- Recent Activity -->
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Thông báo gần đây </h5>
                                <div class="activity">

                                    <c:forEach var="item" items="${notifications}">
                                        <div class="activity-item d-flex">
                                            <div class="activite-label">${item.convertCreatedAt()}</div>
                                            <i class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
                                            <div class="activity-content"> ${item.title}</div>
                                        </div>
                                    </c:forEach>

                                </div>
                            </div>
                        </div><!-- End Recent Activity -->

                        <!-- News & Updates Traffic -->
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Bài viết mới nhất </h5>
                                <div class="news">
                                    <c:forEach var="item" items="${recentPosts}">
                                        <div class="post-item clearfix d-flex">
                                            <div class="me-2" style="height: 4rem; width: 4rem; flex-shrink: 0;">
                                                <c:set var="avatar" value="${item.getUserID().avatar}" />
                                                <c:choose>
                                                    <c:when test="${empty avatar}">
                                                        <img src="/images/no-avatar.jpg" alt="avatar"
                                                            class="rounded-circle w-100 h-100" style="object-fit: cover;"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="/getImage/${avatar}" alt="avatar"
                                                            class="rounded-circle w-100 h-100" style="object-fit: cover;"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div>
                                                <h4><a href="/posts/${item.getID()}/${item.getSlug()}.html">${item.title} ${item.convertCreatedAt()} </a></h4>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div><!-- End sidebar recent posts-->
                            </div>
                        </div><!-- End News & Updates -->
                    </div><!-- End Right side columns -->
                </div>
            </section>
        </main><!-- End #main -->

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
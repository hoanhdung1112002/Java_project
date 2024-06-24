<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html class="no-js" lang="zxx">
    <%@ include file="../layouts/head.jsp" %>
   <body>

    <%@ include file="../layouts/header.jsp" %>

    <main>
        <section class="wall-info">
            <div class="container p-4">
                <div class="d-flex justify-content-between flex-column flex-sm-row py-lg-3">
                    <div class="d-flex">
                        <div style="height: 5rem; width: 5rem;" class="flex-shrink-0">
                            <c:set var="avatar" value="${user.avatar}" />
                            <c:choose>
                                <c:when test="${empty avatar}">
                                    <img src="/images/no-avatar.jpg" alt="avatar"
                                        class="rounded-circle avatar-image" />
                                </c:when>
                                <c:otherwise>
                                    <img src="/getImage/${avatar}" alt="avatar"
                                        class="rounded-circle avatar-image" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="ml-4">
                            <h5 class="m-0 fw-bold fw">
                                ${user.fullName == null or user.fullName == '' ? user.username : user.fullName}
                            </h5>
                            <p class="m-0 mb-1">
                                @${user.username}
                            </p>

                            <c:if test="${not empty authLogin}">
                                <c:if test="${authLogin.ID ne user.ID}">
                                    <button type="button" class="btn-text fs-14" data-toggle="modal" data-target="#reportModal">
                                        <i class="fas fa-flag"></i> Báo cáo
                                    </button>
                                </c:if>
                            </c:if>

                            <!-- Modal -->
                            <div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="reportModalLabel">Nội dung báo cáo</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <input type="hidden" name="userID" id="userID" value="${user.ID}">
                                            <p class="mb-1">Lý do báo cáo người dùng này</p>
                                            <div class="form-check mb-1">
                                                <input class="form-check-input" type="radio" name="content" id="op1" value="Spam" checked>
                                                <label class="form-check-label" for="op1">
                                                    Spam
                                                </label>
                                            </div>
                                            <div class="form-check mb-1">
                                                <input class="form-check-input" type="radio" name="content" id="op2" value="Vi phạm qui tắc">
                                                <label class="form-check-label" for="op2">
                                                    Vi phạm qui tắc
                                                </label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="radio" name="content" id="op3" value="Sự quấy rầy">
                                                <label class="form-check-label" for="op3">
                                                    Sự quấy rầy
                                                </label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="radio" name="content" id="op4" value="op4">
                                                <label class="form-check-label" for="op4">
                                                    Khác
                                                </label>
                                            </div>
                                            <textarea class="form-control" placeholder="Mô tả chi tiết" id="input-op4" rows="5" style="display: none;"></textarea>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary btn-send-report">Báo cáo</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex align-items-start mt-3 mt-sm-0">
                        <c:if test="${not empty authLogin}">
                            <div class="mr-2">
                                <a href="/room/create/${user.ID}" class="btn-wall-inbox" title="Nhắn tin">
                                    <i class="fab fa-facebook-messenger"></i>
                                </a>
                            </div>
                            <c:if test="${authLogin.ID ne user.ID}">
                                <c:choose>
                                    <c:when test="${isFollow eq true}">
                                        <button data-type="1" class="btn-unfollow btn-follow btn button" style="padding: 13px;">
                                            <i class="fas fa-check"></i> Đang theo dõi
                                        </button>
                                        <button data-type="0" class="btn-isfollow btn-follow btn-line" style="height: 40px; display: none;">
                                            <i class="fas fa-plus"></i> Theo dõi
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button data-type="1" class="btn-unfollow btn-follow btn button" style="display: none; padding: 13px;">
                                            <i class="fas fa-check"></i> Đang theo dõi
                                        </button>
                                        <button data-type="0" class="btn-isfollow btn-follow btn-line" style="height: 40px;">
                                            <i class="fas fa-plus"></i> Theo dõi
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>

        <!--================Blog Area =================-->
        <section class="blog_area section-padding pt-0">
            <div style="border-top: 1px solid #dee2e6; box-shadow: 0 2px 2px 0 rgba(0,0,0,.1);">
                <div class="container">
                    <ul class="nav nav-tabs" id="myTab" role="tablist" style="border-bottom: none;">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="post-tab" data-bs-toggle="tab" data-bs-target="#post-tab-pane" type="button" role="tab" aria-controls="post-tab-pane" aria-selected="true">
                                Bài viết
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="answer-tab" data-bs-toggle="tab" data-bs-target="#answer-tab-pane" type="button" role="tab" aria-controls="answer-tab-pane" aria-selected="false">
                                Câu trả lời
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="following-tab" data-bs-toggle="tab" data-bs-target="#following-tab-pane" type="button" role="tab" aria-controls="following-tab-pane" aria-selected="false">
                                Đang theo dõi
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="follower-tab" data-bs-toggle="tab" data-bs-target="#follower-tab-pane" type="button" role="tab" aria-controls="follower-tab-pane" aria-selected="false">
                                Người theo dõi
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="inbox-tab" data-bs-toggle="tab" data-bs-target="#inbox-tab-pane" type="button" role="tab" aria-controls="inbox-tab-pane" aria-selected="false">
                                Liên hệ
                            </button>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="container">
                <div class="row mt-4">
                    <div class="col-lg-8 mb-5 mb-lg-0">
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="post-tab-pane" role="tabpanel" aria-labelledby="post-tab" tabindex="0">
                                <div class="row">
                                    <div class="col-lg-12 mb-5 mb-lg-0">
                                        <div class="blog_left_sidebar">
                                            <c:if test="${not empty posts}">
                                                <c:forEach var="item" items="${posts}">
                                                    <article class="blog_item">
                                                        <div class="p-3 py-4 d-flex blog_details">
                                                            <div class="mr-3">
                                                                <div style="height: 4.9rem; width: 4.9rem;">
                                                                    <c:set var="avatar" value="${item.avatar}" />
                                                                    <c:choose>
                                                                        <c:when test="${empty avatar}">
                                                                            <img src="/images/no-avatar.jpg" alt="avatar" class="avatar-image"/>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <img src="/getImage/${avatar}" alt="avatar" class="avatar-image"/>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                            <div>
                                                                <a class="d-inline-block" href="/posts/${item.getID()}/${item.getSlug()}.html">
                                                                    <h2>${item.getTitle()}</h2>
                                                                </a>
                                                                <ul class="blog-info-link">
                                                                    <li>
                                                                        <a href="#">
                                                                            <i class="fas fa-calendar-alt"></i>
                                                                            ${item.convertCreatedAt()}
                                                                        </a>
                                                                    </li>
                                                                    <li>
                                                                        <a href="#"><i class="fas fa-eye"></i> ${item.getTotalView()}</a>
                                                                    </li>
                                                                    <li>
                                                                        <a href="#"><i class="fas fa-thumbs-up"></i> ${item.getTotalLike()}</a>
                                                                    </li>
                                                                    <li>
                                                                        <a href="#"><i class="fa fa-comments"></i> ${item.getTotalComment()}</a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </article>
                                                </c:forEach>
                
                                                <nav class="blog-pagination justify-content-center d-flex">
                                                    <ul class="pagination">
                                                        <li class="page-item">
                                                            <a href="#" class="page-link" aria-label="Previous">
                                                                <i class="ti-angle-left"></i>
                                                            </a>
                                                        </li>
                                                        <li class="page-item">
                                                            <a href="#" class="page-link">1</a>
                                                        </li>
                                                        <li class="page-item active">
                                                            <a href="#" class="page-link">2</a>
                                                        </li>
                                                        <li class="page-item">
                                                            <a href="#" class="page-link" aria-label="Next">
                                                                <i class="ti-angle-right"></i>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                            </c:if>
                                            
                                            <c:if test="${empty posts}">
                                                <p class="text-center py-5">Không có kết quả phù hợp</p>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="answer-tab-pane" role="tabpanel" aria-labelledby="answer-tab" tabindex="0">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="comment-list-wrapper overflow-y-auto scroll-custom" style="max-height: 100vh;">
                                            <c:if test="${not empty comments}">
                                                <c:forEach var="item" items="${comments}">
                                                    <div class="comment-list mb-3">
                                                        <div class="single-comment justify-content-start d-flex flex-column">
                                                            <div class="user justify-content-start flex-column d-flex">
                                                                <a href="/posts/${item.postID.getID()}/${item.postID.getSlug()}.html" class="d-block mb-3 fs-18 font-weight-bold">${item.postID.title}</a>
                                                                <div class="d-flex">
                                                                    <div class="thumb" style="height: 3rem; width: 3rem;">
                                                                        <c:set var="avatar" value="${item.getUserID().avatar}" />
                                                                        <c:choose>
                                                                            <c:when test="${empty avatar}">
                                                                                <img src="/images/no-avatar.jpg" alt="avatar" class="rounded-circle avatar-image"/>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <img src="/getImage/${avatar}" alt="avatar" class="rounded-circle avatar-image"/>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                    <div class="pl-3">
                                                                        <div class="m-0 fw-bolder">
                                                                            ${item.getUserID().fullName == null or item.getUserID().fullName == '' ? item.getUserID().username : item.getUserID().fullName}
                                                                        </div>
                                                                        <p class="date fs-14 mb-0">
                                                                            Đã trả lời ${item.convertCreatedAt()}
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                                <div class="desc mt-3 overflow-y-auto scroll-none" style="max-height: 200px;">
                                                                    ${item.content}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>

                                            <c:if test="${empty comments}">
                                                <p class="text-center py-5">Không có kết quả phù hợp</p>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="following-tab-pane" role="tabpanel" aria-labelledby="following-tab" tabindex="0">
                                <div class="row">
                                    <c:if test="${not empty listFollowing.content}">
                                        <c:forEach var="item" items="${listFollowing.content}">
                                            <div class="mb-4 col-12 col-sm-6 col-xl-4">
                                                <div class="d-flex align-items-center item-follow">
                                                    <a href="/users/wall/${item.getFollowing().ID}/${item.getFollowing().username}" class="d-block" style="height: 4rem; width: 4rem; flex-shrink: 0;">
                                                        <c:choose>
                                                            <c:when test="${empty item.getFollowing().avatar}">
                                                                <img src="/images/no-avatar.jpg" alt="avatar"
                                                                    class="rounded-circle avatar-image" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="/getImage/${item.getFollowing().avatar}" alt="avatar"
                                                                    class="rounded-circle avatar-image" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                    <div class="ml-3">
                                                        <h5 class="m-0 fw-bold fw fs-18">
                                                            <a href="/users/wall/${item.getFollowing().ID}/${item.getFollowing().username}">
                                                                ${item.getFollowing().fullName == null or item.getFollowing().fullName == '' ? item.getFollowing().username : item.getFollowing().fullName}
                                                            </a>
                                                        </h5>
                                                        <p class="m-0 mb-1">
                                                            @${item.getFollowing().username}
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                                
                                <c:if test="${empty listFollowing.content}">
                                    <p class="text-center py-5">Không có kết quả phù hợp</p>
                                </c:if>
                            </div>
                            <div class="tab-pane fade" id="follower-tab-pane" role="tabpanel" aria-labelledby="follower-tab" tabindex="0">
                                <div class="row">
                                    <c:if test="${not empty listFollower.content}">
                                        <c:forEach var="item" items="${listFollower.content}">
                                            <div class="mb-4 col-12 col-sm-6 col-xl-4">
                                                <div class="d-flex align-items-center item-follow">
                                                    <a href="/users/wall/${item.getFollower().ID}/${item.getFollower().username}" class="d-block" style="height: 4rem; width: 4rem; flex-shrink: 0;">
                                                        <c:choose>
                                                            <c:when test="${empty item.getFollower().avatar}">
                                                                <img src="/images/no-avatar.jpg" alt="avatar"
                                                                    class="rounded-circle avatar-image" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="/getImage/${item.getFollower().avatar}" alt="avatar"
                                                                    class="rounded-circle avatar-image" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                    <div class="ml-3">
                                                        <h5 class="m-0 fw-bold fw fs-18">
                                                            <a href="/users/wall/${item.getFollower().ID}/${item.getFollower().username}">
                                                                ${item.getFollower().fullName == null or item.getFollower().fullName == '' ? item.getFollower().username : item.getFollower().fullName}
                                                            </a>
                                                        </h5>
                                                        <p class="m-0 mb-1">
                                                            @${item.getFollower().username}
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                                
                                <c:if test="${empty listFollower.content}">
                                    <p class="text-center py-5">Không có kết quả phù hợp</p>
                                </c:if>
                            </div>
                            <div class="tab-pane fade" id="inbox-tab-pane" role="tabpanel" aria-labelledby="inbox-tab" tabindex="0">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="card">
                                            <div class="card-body">
                                                <form method="POST" action="/posts/store" enctype="multipart/form-data" class="row h-100">
                                                    <div class="col-12 posts-list h-100 overflow-y-auto scroll-custom scroll-none">
                                                        <textarea class="tinymce-editor form-control" name="content" id="content" cols="30" rows="10"></textarea>
                                                    </div>
                                                    <div class="col-12 mt-3 d-flex justify-content-end">
                                                        <button type="submit" class="btn button">
                                                            Gửi
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="blog_right_sidebar">
                            <aside class="single_sidebar_widget popular_post_widget">
                                <h3 class="widget_title">Bài đăng được yêu thích nhất</h3>
                                
                                <c:forEach var="item" items="${postsTopLike}">
                                    <div class="media post_item">
                                        <div class="media-body pl-0">
                                            <a href="/posts/${item.getID()}/${item.getSlug()}.html">
                                                <h3 class="title-post">${item.title}</h3>
                                            </a>
                                            <div class="d-flex">
                                                <p>
                                                    ${item.convertCreatedAt()}
                                                </p>
                                                <p class="pl-4">
                                                    ${item.getTotalLike()} lượt thích
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </aside>

                            <aside class="single_sidebar_widget popular_post_widget">
                                <h3 class="widget_title">Bài đăng được quan tâm nhất</h3>
                                
                                <c:forEach var="item" items="${postsTopView}">
                                    <div class="media post_item">
                                        <div class="media-body pl-0">
                                            <a href="/posts/${item.getID()}/${item.getSlug()}.html">
                                                <h3 class="title-post">${item.title}</h3>
                                            </a>
                                            <div class="d-flex">
                                                <p>
                                                    ${item.convertCreatedAt()}
                                                </p>
                                                <p class="pl-4">
                                                    ${item.getTotalView()} lượt xem
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </aside>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================Blog Area =================-->
    </main>
    
    <%@ include file="../layouts/footer.jsp" %>
    
    <script>
        $(document).ready(() => {

            // Handle follow
            $('.btn-follow').on('click', function(e) {
                const type = $(this).data('type');
                const userID = $("#userID").val();
                $.ajax({
                    type: "POST",
                    url: `/users/follow/` + userID,
                    data: false,
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                }).done(function(response) {
                    if (type == 1) {
                        $('.btn-isfollow').show();
                        $('.btn-unfollow').hide();
                    } else {
                        $('.btn-isfollow').hide();
                        $('.btn-unfollow').show();
                    }
                }).fail(function(xhr, status, error) {
                    showMessage("error");
                });
            });

            // Checked option other
            $('input[name="content"]').on('change', function () {
                if ($(this).is(':checked')) {
                    if ($(this).val() == "op4") {
                        $('#input-op4').show();
                    } else {
                        $('#input-op4').hide();
                    }
                }
            });

            // Send report
            $(document).on("click", ".btn-send-report", () => {
                let data = {
                    'content': $('input[name="content"]:checked').val() == "op4" ? $('#input-op4').val() : $('input[name="content"]:checked').val(),
                    'userID': $("#userID").val(),
                }
                showMessage("success", "Đã gửi báo cáo");
                $('#reportModal').modal('hide');

                // $.ajax({
                //     type: "POST",
                //     url: `/comments/store`,
                //     // dataType: "application/json",
                //     data: data,
                //     headers: {
                //         'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                //     },
                // }).done(function(response) {
                //     location.reload();
                // }).fail(function(xhr, status, error) {
                //     showMessage("error");
                // });
            });
        });
    </script>

    </body>
</html>
<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html class="no-js" lang="zxx">
    <%@ include file="../layouts/head.jsp" %>
   <body>

    <%@ include file="../layouts/header.jsp" %>

    <section class="blog_area single-post-area section-padding">
        <div class="container">
            <div class="position-relative" style="height: 72vh;">
                <div class="row h-100">
                    <div style="overflow-x: hidden;" class="col-lg-8 posts-list h-100 overflow-y-auto scroll-custom scroll-none">
                        <c:if test="${post.isPresent()}">
                            <div class="single-post">
                                <c:set var="avatar" value="${post.get().avatar}" />
                                <c:choose>
                                    <c:when test="${empty avatar}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="feature-img mb-3" style="height: 330px;">
                                            <img class="img-fluid h-100 w-100" style="object-fit: cover;" src="/getImage/${avatar}" alt="">
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="blog_details pt-0">
                                    <h2 style="font-size: 28px;">
                                        ${post.get().title}
                                    </h2>
                                    <ul class="blog-info-link mt-3 mb-4">
                                        <li>
                                            <a href="/users/wall/${post.get().userID.ID}/${post.get().userID.username}"><i class="fa fa-user"></i>
                                                ${post.get().userID.fullName == null or post.get().userID.fullName == '' ? post.get().userID.username : post.get().userID.fullName}
                                            </a>
                                        </li>

                                        <li>
                                            <span>
                                                <i class="fas fa-calendar-alt"></i>
                                                ${post.get().convertCreatedAt()}
                                            </span>
                                        </li>
                                        <li>
                                            <span><i class="fas fa-eye"></i> ${post.get().getTotalView()} lượt xem</span>
                                        </li>
                                        <li>
                                            <span><i class="fas fa-thumbs-up"></i> <span data-total="${post.get().getTotalLike()}" id="total-like">${post.get().getTotalLike()}</span> lượt thích</span>
                                        </li>

                                        <li><span><i class="fa fa-comments"></i> ${post.get().totalComment} bình luận</span></li>
                                    </ul>
                                    <div class="w-100 pb-3 text-justify">
                                        ${post.get().content}
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <div class="navigation-top">
                            <div class="d-sm-flex justify-content-between text-center">
                                <p class="like-info"><span class="align-middle"><i class="fa fa-heart"></i></span> 
                                    ${post.get().getTotalLike()} người khác thích bài viết này
                                </p>
                                <div class="col-sm-4 text-center my-2 my-sm-0">
                                    <!-- <p class="comment-count"><span class="align-middle"><i class="fa fa-comment"></i></span> 06 Comments</p> -->
                                </div>
                                <ul class="social-icons">
                                    <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                    <li><a href="#"><i class="fab fa-dribbble"></i></a></li>
                                    <li><a href="#"><i class="fab fa-behance"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="d-none d-lg-block col-lg-4 h-100 overflow-y-auto scroll-custom">
                        <div class="blog_right_sidebar">
                            <aside class="single_sidebar_widget search_widget">
                                <form action="/posts/search">
                                    <div class="form-group">
                                        <div class="input-group mb-3">
                                            <input type="text"
                                                   name="search"
                                                   class="form-control"
                                                   placeholder='Từ khóa cần tìm'
                                                   onfocus="this.placeholder = ''"
                                                   onblur="this.placeholder = 'Từ khóa cần tìm'">
                                            <div class="input-group-append">
                                                <button class="btns" type="submit"><i class="ti-search"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </aside>
                            <aside class="single_sidebar_widget post_category_widget">
                                <h4 class="widget_title">Danh mục</h4>
                                <ul class="list cat-list">
                                    <c:forEach var="category" items="${categories}">
                                        <li>
                                            <a href="<c:url value='/posts/category/'/>${category.getID()}" class="d-flex">
                                                <p>${category.getCategoryName()}</p>
                                                <p> (37)</p>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </aside>
                            <aside class="single_sidebar_widget popular_post_widget">
                                <h3 class="widget_title">Bài đăng gần đây</h3>
                                
                                <c:forEach var="item" items="${recentPosts}">
                                    <div class="media post_item">
                                        <div style="height: 3rem; width: 3rem;">
                                            <c:set var="avatar" value="${item.getUserID().avatar}" />
                                            <c:choose>
                                                <c:when test="${empty avatar}">
                                                    <img src="/images/no-avatar.jpg" alt="avatar"
                                                        class="rounded-circle avatar-image"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="/getImage/${avatar}" alt="avatar"
                                                        class="rounded-circle avatar-image"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="media-body pl-3">
                                            <a href="/posts/${item.getID()}/${item.getSlug()}.html">
                                                <h3 class="title-post">${item.title}</h3>
                                            </a>
                                            <p>
                                                ${item.convertCreatedAt()}
                                            </p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </aside>
                            <aside class="single_sidebar_widget tag_cloud_widget">
                                <h4 class="widget_title">Tag Clouds</h4>
                                <ul class="list">
                                    <li>
                                        <a href="#">project</a>
                                    </li>
                                    <li>
                                        <a href="#">love</a>
                                    </li>
                                    <li>
                                        <a href="#">technology</a>
                                    </li>
                                    <li>
                                        <a href="#">travel</a>
                                    </li>
                                    <li>
                                        <a href="#">restaurant</a>
                                    </li>
                                    <li>
                                        <a href="#">life style</a>
                                    </li>
                                    <li>
                                        <a href="#">design</a>
                                    </li>
                                    <li>
                                        <a href="#">illustration</a>
                                    </li>
                                </ul>
                            </aside>
                            <aside class="single_sidebar_widget instagram_feeds">
                                <h4 class="widget_title">Instagram Feeds</h4>
                                <ul class="instagram_row flex-wrap">
                                    <li>
                                        <a href="#">
                                            <img class="img-fluid"
                                                 src="/images/post/post_5.png"
                                                 alt="">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img class="img-fluid"
                                                 src="/images/post/post_6.png"
                                                 alt="">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img class="img-fluid"
                                                 src="/images/post/post_7.png"
                                                 alt="">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img class="img-fluid"
                                                 src="/images/post/post_8.png"
                                                 alt="">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img class="img-fluid"
                                                 src="/images/post/post_9.png"
                                                 alt="">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img class="img-fluid"
                                                 src="/images/post/post_10.png"
                                                 alt="">
                                        </a>
                                    </li>
                                </ul>
                            </aside>
                        </div>
                    </div>
                </div>

                <div class="list-post-action position-absolute d-flex flex-column align-items-center">
                    <a href="/users/wall/${post.get().userID.ID}/${post.get().userID.username}" class="d-block" style="width: 45px; height: 45px; margin-bottom: 20px;">
                        <c:set var="avatarUser" value="${post.get().userID.avatar}" />
                        <c:choose>
                            <c:when test="${empty avatarUser}">
                                <img class="rounded-circle avatar-image" id="img-account" src="/images/no-avatar.jpg" alt="avatar"
                                    />
                            </c:when>
                            <c:otherwise>
                                <img class="rounded-circle avatar-image" id="img-account" src="/getImage/${avatarUser}" alt="avatar"
                                    />
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <c:choose>
                        <c:when test="${not empty authLogin}">
                            <c:if test="${isLiked eq true}">
                                <button id="like-post" data-check="1" class="btn-circle-outline">
                                    <i class="fas fa-thumbs-up" style="color: #4848ff;" ></i>
                                </button>
                            </c:if>
                            <c:if test="${isLiked eq false}">
                                <button id="like-post" data-check="0" class="btn-circle-outline">
                                    <i class="far fa-thumbs-up"></i>
                                </button>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <button class="btn-circle-outline" type="button" data-toggle="modal" data-target="#loginModal">
                                <i class="far fa-thumbs-up"></i>
                            </button>
                        </c:otherwise>
                    </c:choose>
                    <button id="btn-comment-top" class="btn-circle-outline">
                        <i class="far fa-comment"></i>
                    </button>

                    <c:choose>
                        <c:when test="${not empty authLogin}">
                            <button class="btn-circle-outline" type="button" data-toggle="modal" data-target="#reportPost">
                                <i class="far fa-flag"></i>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button class="btn-circle-outline" type="button" data-toggle="modal" data-target="#loginModal">
                                <i class="far fa-flag"></i>
                            </button>
                        </c:otherwise>
                    </c:choose>

                    <!-- Modal Login -->
                    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="loginModalLabel">ĐĂNG NHẬP</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="card-body p-3">
                                        <div class="text-center mb-5">
                                            <img style="max-width: 120px;" src="/images/logo/logo.png" alt="Logo">
                                        </div>
            
                                        <form class="container" method="POST" action="/auth/login">
                                            <div class="input-group mb-4">
                                                <div class="input-group-append"><span class="input-group-text"><i class="fas fa-user"></i></span></div>
                                                <input id="email" type="text" name="email" class="form-control" placeholder="Tài khoản" required>
                                            </div>
            
                                            <div class="input-group">
                                                <div class="input-group-append"><span class="input-group-text"><i class="fas fa-key"></i></span></div>
                                                <input id="password" type="password" name="password" class="form-control" placeholder="Mật khẩu" required>
                                            </div>
            
                                            <div class="row mb-3 btn-offset-parent">
                                                <div class="col-12 my-3 text-center">
                                                    <span>Chưa có tài khoản</span>
                                                    <a class="text-primary" href="/auth/register">Đăng ký</a>
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit" class="btn py-4 btn-primary w-100">
                                                        Đăng nhập
                                                    </button>
                                                </div>
                                            </div>
            
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal -->
                    <div class="modal fade" id="reportPost" tabindex="-1" aria-labelledby="reportPostLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="reportPostLabel">Nội dung báo cáo</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="postID" id="postID" value="${post.get().ID}">
                                    <p class="mb-1">Lý do báo cáo bài viết này</p>
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

            <div class="row">
                <div class="col-12">
                    
                    <c:if test="${not empty post.get().userID.introduce}">
                        <div class="blog-author mt-4">
                            <div class="media align-items-center">
                                <div style="height: 5rem; width: 5rem;">
                                    <c:set var="avatar" value="${post.get().userID.avatar}" />
                                    <c:choose>
                                        <c:when test="${empty avatar}">
                                            <img src="/images/no-avatar.jpg" alt="avatar"
                                                class="rounded-circle avatar-image"
                                                />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/getImage/${avatar}" alt="avatar"
                                                class="rounded-circle avatar-image"
                                                />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="media-body ml-4">
                                    <a href="#">
                                        <h4>
                                            ${post.get().userID.fullName == null or post.get().userID.fullName == '' ? post.get().userID.username : post.get().userID.fullName}
                                            <span style="font-size: 14px; color: #999999;">
                                                | Tham gia <fmt:formatDate value="${post.get().userID.getCreateAt()}" pattern="dd/MM/yyyy" />
                                            </span>
                                        </h4>
                                    </a>
                                    <p>
                                        ${post.get().userID.introduce}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <div id="moc-cuon"></div>

                    <div class="comment-form">
                        <h4>Để lại câu trả lời</h4>
                        <div id="reply-alert" class="d-none mb-3">
                            <div class="alert-success d-inline-block rounded px-3" style="line-height: 40px;">
                                <input type="hidden" name="postID" id="postID" value="${post.get().ID}">
                                <input type="hidden" name="parentID" id="parentID" value="0">
                                Bạn đang trả lời bình luận của <span id="reply-name"></span>
                            </div>
                            <button id="btn-cancel" class="ml-3 btn btn-secondary">Hủy</button>
                        </div>
                        <c:choose>
                            <c:when test="${not empty authLogin}">
                                <form class="form-contact comment_form" action="#" id="commentForm">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group mb-3">
                                                <textarea class="form-control w-100 tinymce-editor" name="content" id="content"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group d-flex justify-content-end">
                                        <a id="btn-send-comment" class="btn button" style="color: #fff;">Gửi</a>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <p class="mb-1">Để trả lời bài viết vui lòng đăng nhập!</p>
                                <a href="/auth/login" class="button btn">
                                    Đăng nhập
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="comments-area mt-5">
                        <div class="d-flex align-items-center mb-4">
                            <h4 class="text-uppercase m-0 mr-3">${post.get().totalComment} câu trả lời</h4>
                            <hr class="m-0">
                        </div>

                        <div class="comment-list-wrapper overflow-y-auto scroll-custom" style="max-height: 100vh;">
                            <c:forEach var="item" items="${comments}">
                                <c:if test="${item.parentID eq 0}">
                                    <div class="comment-list">
                                        <div class="single-comment justify-content-start d-flex flex-column">
                                            <div class="user justify-content-start d-flex">
                                                <a href="/users/wall/${item.getUserID().ID}/${item.getUserID().username}" class="thumb d-block" style="height: 4.5rem; width: 4.5rem;">
                                                    <c:set var="avatar" value="${item.getUserID().avatar}" />
                                                    <c:choose>
                                                        <c:when test="${empty avatar}">
                                                            <img src="/images/no-avatar.jpg" alt="avatar"
                                                                class="rounded-circle avatar-image"
                                                                />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="/getImage/${avatar}" alt="avatar"
                                                                class="rounded-circle avatar-image"
                                                                />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                                <div class="desc">
                                                    <p class="comment">
                                                        ${item.content}
                                                    </p>
                                                    <div class="d-flex justify-content-start">
                                                        <div class="d-flex align-items-center">
                                                            <h5>
                                                                <a href="/users/wall/${item.getUserID().ID}/${item.getUserID().username}">
                                                                    ${item.getUserID().fullName == null or item.getUserID().fullName == '' ? item.getUserID().username : item.getUserID().fullName}
                                                                </a>
                                                            </h5>
                                                            <p class="date">
                                                                ${item.convertCreatedAt()}
                                                            </p>
                                                        </div>
                                                        <c:choose>
                                                            <c:when test="${not empty authLogin}">
                                                                <div class="reply-btn">
                                                                    <a class="btn-reply text-success btn-reply-comment text-uppercase"
                                                                        data-id="${item.ID}"
                                                                        data-name="${item.getUserID().fullName == null or item.getUserID().fullName == '' ? item.getUserID().username : item.getUserID().fullName}">
                                                                        Trả lời
                                                                    </a>
                                                                </div>

                                                                <c:if test="${authLogin.ID eq item.getUserID().ID}">
                                                                    <div class="reply-btn">
                                                                        <a class="btn-reply btn-delete-comment text-danger text-uppercase"
                                                                            data-id="${item.ID}">
                                                                            Xóa
                                                                        </a>
                                                                    </div>
                                                                </c:if>
                                                            </c:when>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:forEach var="subItem" items="${comments}">
                                                <c:if test="${subItem.parentID eq item.ID}">
                                                    <div class="sub-comment justify-content-between d-flex">
                                                        <div class="user justify-content-between d-flex">
                                                            <a href="/users/wall/${subItem.getUserID().ID}/${subItem.getUserID().username}" class="d-block thumb" style="height: 4.5rem; width: 4.5rem;">
                                                                <c:set var="subAvatar" value="${subItem.getUserID().avatar}" />
                                                                <c:choose>
                                                                    <c:when test="${empty subAvatar}">
                                                                        <img src="/images/no-avatar.jpg" alt="avatar" class="rounded-circle avatar-image" />
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="/getImage/${subAvatar}" alt="avatar" class="rounded-circle avatar-image" />
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </a>
                                                            <div class="desc">
                                                                <p class="comment">
                                                                    ${subItem.content}
                                                                </p>
                                                                <div class="d-flex justify-content-start">
                                                                    <div class="d-flex align-items-center">
                                                                        <h5>
                                                                            <a href="/users/wall/${subItem.getUserID().ID}/${subItem.getUserID().username}">
                                                                                ${subItem.getUserID().fullName == null or subItem.getUserID().fullName == '' ? subItem.getUserID().username : subItem.getUserID().fullName}
                                                                            </a>
                                                                        </h5>
                                                                        <p class="date"> ${subItem.convertCreatedAt()} </p>
                                                                    </div>

                                                                    <c:choose>
                                                                        <c:when test="${not empty authLogin}">
                                                                            <c:if test="${authLogin.ID eq subItem.getUserID().ID}">
                                                                                <div class="reply-btn">
                                                                                    <a class="btn-reply btn-delete-comment text-danger text-uppercase"
                                                                                        data-id="${subItem.ID}">
                                                                                        Xóa
                                                                                    </a>
                                                                                </div>
                                                                            </c:if>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <hr>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@ include file="../layouts/footer.jsp" %>

    <script>
        $(document).ready(() => {

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
                    'postID': $("#postID").val(),
                }
                showMessage("success", "Đã gửi báo cáo");
                $('#reportModal').modal('hide');

                console.log(data);

                $.ajax({
                    type: "POST",
                    url: `/report/store`,
                    data: data,
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                }).done(function(response) {
                    showMessage("success", "Báo cáo đã được gửi", () => location.reload());
                }).fail(function(xhr, status, error) {
                    showMessage("error");
                });
            });

            //Handle like post
            $(document).on('click', '#like-post', function(e) {
                const check = $(this).data('check');
                const postID = $("#postID").val();
                let data = {
                    'postID': postID,
                    'check': check
                }

                $.ajax({
                    type: "POST",
                    url: `/posts/like/`,
                    data: data,
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                }).done(function(response) {
                    const totalLike = $("#total-like");
                    let total = totalLike.data('total');

                    if (check == 1) {
                        $('#like-post i').removeClass('fas').addClass('far');
                        $('#like-post i').css('color', '#adb5bd');
                        $('#like-post').data('check', 0);
                        totalLike.text(parseInt(total) - 1);
                        totalLike.data('total', parseInt(total) - 1);
                    } else if (check == 0) {
                        $('#like-post i').removeClass('far').addClass('fas');
                        $('#like-post i').css('color', '#4848ff');
                        $('#like-post').data('check', 1);
                        totalLike.text(parseInt(total) + 1);
                        totalLike.data('total', parseInt(total) + 1);
                    }
                }).fail(function(xhr, status, error) {
                    showMessage("error");
                });
            });

            // Button comment top
            $("#btn-comment-top").on("click", function() {
                $('html, body').animate({
                    scrollTop: $("#moc-cuon").offset().top
                }, 400);
            });

            // Reply comment
            $(".btn-reply-comment").on("click", function() {
                const id = $(this).data("id");
                const name = $(this).data("name");
                $("#reply-name").text(name);
                $("#parentID").val(id);
                $("#reply-alert").removeClass("d-none").addClass("d-flex");

                $('html, body').animate({
                    scrollTop: $("#moc-cuon").offset().top
                }, 400);
            });

            // Hủy reply comment
            $("#btn-cancel").on("click", function() {
                $("#parentID").val(0);
                $("#reply-alert").removeClass("d-flex").addClass("d-none");
            });

            // Delete reply comment
            $(".btn-delete-comment").on("click", function() {
                const id = $(this).data('id');
                Swal.fire({
                    icon: 'question',
                    text: `Xác nhận xóa bình luận ?`,
                    showCancelButton: true,
                    confirmButtonText: 'Xác nhận',
                    cancelButtonText: 'Hủy bỏ',
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "GET",
                            url: `/comments/destroy/` + id,
                            headers: {
                                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                            },
                        }).done(function(response) {
                            location.reload();
                        }).fail(function(xhr, status, error) {
                            showMessage("error");
                        });
                    }
                });
            });

            // Send comment
            $(document).on("click", "#btn-send-comment", () => {
                const content = tinymce.get('content').getContent();
                if (content == null || content.trim() == "") {
                    showMessage("error", "Vui lòng nhập nội dung");
                    return;
                }

                let data = {
                    'content': content,
                    'postID': $("#postID").val(),
                    'parentID': $("#parentID").val()
                }

                $.ajax({
                    type: "POST",
                    url: `/comments/store`,
                    // dataType: "application/json",
                    data: data,
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                }).done(function(response) {
                    location.reload();
                }).fail(function(xhr, status, error) {
                    showMessage("error");
                });
            });
        });
    </script>
    </body>
</html>
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
                <div class="d-flex justify-content-between py-lg-3">
                    <div class="d-flex">
                        <div style="height: 5rem; width: 5rem;">
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
                            <div>
                                ${user.introduce}
                            </div>
                        </div>
                    </div>

                    <div>
                        <a href="/users/profile/edit" class="btn button" style="padding: 12px; letter-spacing: 0px; color: #fff;">
                            <i class="far fa-edit"></i> Cập nhật hồ sơ
                        </a>
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
                    </ul>
                </div>
            </div>
            <div class="container">
                <div class="row mt-4">
                    <div class="col-12 mb-5 mb-lg-0">
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

                                                        <div class="dropdown post-action">
                                                            <button class="btn-text" type="button" data-toggle="dropdown" aria-expanded="false">
                                                                <i class="fs-20 fas fa-ellipsis-h"></i>
                                                            </button>
                                                            <div class="dropdown-menu dropdown-menu-right">
                                                                <a data-id="${item.getID()}" class="dropdown-item btn-delete-data">
                                                                    <i style="width: 18px;" class="far fa-trash-alt"></i>
                                                                    Xóa bài viết
                                                                </a>
                                                                <a href="/posts/edit/${item.getID()}" class="dropdown-item">
                                                                    <i style="width: 18px;" class="far fa-edit"></i>
                                                                    Cập nhật bài viết
                                                                </a>
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
                                                                            <img src="/images/no-avatar.jpg" alt="avatar"
                                                                                class="rounded-circle avatar-image" />
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <img src="/getImage/${avatar}" alt="avatar"
                                                                                class="rounded-circle avatar-image" />
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <div class="pl-3">
                                                                    <div class="m-0 fw-bolder">
                                                                        ${item.getUserID().fullName == null or item.getUserID().fullName == '' ? item.getUserID().username : item.getUserID().fullName}
                                                                    </div>
                                                                    <p class="date fs-14 mb-0">
                                                                        ${item.convertCreatedAt()}
                                                                        <!-- Đã trả lời <fmt:formatDate value="${item.getCreateAt()}" pattern="dd/MM/yyyy HH:mm" /> -->
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
                                
                                <c:if test="${empty listFollowing.content}">
                                    <p class="text-center py-5">Không có kết quả phù hợp</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================Blog Area =================-->
    </main>
    <%@ include file="../layouts/footer.jsp" %>
    <script>
        //Handle delete user
        $(document).on('click', '.btn-delete-data', function(e) {
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
                        url: `/posts/delete/` + id,
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                    }).done(function(response) {
                        showMessage("success", "Bài viết đã xóa thành công", () => location.reload());
                    }).fail(function(xhr, status, error) {
                        showMessage("error");
                    });
                }
            });
        });
    </script>
    </body>
</html>
<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html class="no-js" lang="zxx">
    <%@ include file="./layouts/head.jsp" %>
   <body>
       
    <!-- Preloader Start -->
    <!-- <div id="preloader-active">
        <div class="preloader d-flex align-items-center justify-content-center">
            <div class="preloader-inner position-relative">
                <div class="preloader-circle"></div>
                <div class="preloader-img pere-text">
                    <img src="/images/logo/logo.png" alt="">
                </div>
            </div>
        </div>
    </div> -->
    <!-- Preloader Start -->

    <%@ include file="layouts/header.jsp" %>

    <main>
    <!-- Trending Area Start -->
    <div class="trending-area fix">
        <div class="container">
            <div class="trending-main">
                <!-- Trending Tittle -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="trending-tittle">
                            <strong class="mb-0">Thịnh hành</strong>
                            <!-- <p>Rem ipsum dolor sit amet, consectetur adipisicing elit.</p> -->
                            <div class="trending-animated">
                                <ul id="js-news" class="js-hidden">
                                    <li class="news-item">Nơi chia sẻ kiến thức công nghệ</li>
                                    <li class="news-item">Cập nhật tin tức công nghệ mới nhất.......</li>
                                    <li class="news-item">Đăng bài không giới hạn</li>
                                </ul>
                            </div>
                            
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8">
                        <c:if test="${not empty posts.content}">
                            <c:forEach var="item" items="${posts.content}">
                                <article class="blog_item mb-0">
                                    <div class="p-3 d-flex blog_details">
                                        <div class="mr-3 py-2">
                                            <a class="d-block" href="/users/wall/${item.getUserID().ID}/${item.getUserID().username}" style="height: 3.5rem; width: 3.5rem;">
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
                                        </div>
                                        <div>
                                            <a href="/users/wall/${item.getUserID().ID}/${item.getUserID().username}" class="m-0 d-block">
                                                ${item.getUserID().fullName == null or item.getUserID().fullName == '' ? item.getUserID().username : item.getUserID().fullName}
                                            </a>
                                            <a class="d-inline-block" href="/posts/${item.getID()}/${item.getSlug()}.html">
                                                <h2>${item.getTitle()}</h2>
                                            </a>
                                            <ul class="blog-info-link">
                                                <li>
                                                    <a href="/posts/${item.getID()}/${item.getSlug()}.html">
                                                        <i class="fas fa-calendar-alt"></i>
                                                        ${item.convertCreatedAt()}
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="/posts/${item.getID()}/${item.getSlug()}.html"><i class="fas fa-eye"></i> ${item.getTotalView()}</a>
                                                </li>
                                                <li>
                                                    <a href="/posts/${item.getID()}/${item.getSlug()}.html"><i class="fas fa-thumbs-up"></i> ${item.getTotalLike()}</a>
                                                </li>
                                                <li>
                                                    <a href="/posts/${item.getID()}/${item.getSlug()}.html"><i class="fa fa-comments"></i> ${item.getTotalComment()}</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </article>
                                <hr class="my-3">
                            </c:forEach>

                            <!-- Hiển thị liên kết phân trang -->
                            <c:if test="${posts.totalPages > 1}">
                                <nav class="blog-pagination justify-content-center d-flex mb-5">
                                    <ul class="pagination">
                                        <c:if test="${posts.number > 0}">
                                            <li class="page-item">
                                                <a href="?page=${posts.number}" class="page-link" aria-label="Previous">
                                                    <i class="ti-angle-left"></i>
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="i" begin="1" end="${posts.totalPages }">
                                            <c:if test="${i-1 != posts.number}">
                                                <li class="page-item">
                                                    <a href="?page=${i}" class="page-link">${i}</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${i-1 == posts.number}">
                                                <li class="page-item active">
                                                    <span class="page-link">${i}</span>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${posts.number + 1 ne posts.totalPages}">
                                            <li class="page-item">
                                                <a href="?page=${posts.number+2}" class="page-link" aria-label="Next">
                                                    <i class="ti-angle-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </c:if>
                        </c:if>
                        
                        <c:if test="${empty posts.content}">
                            <p class="text-center py-5">Không có kết quả phù hợp</p>
                        </c:if>

                    </div>
                    <!-- Riht content -->
                    <div class="col-lg-4">
                        <div class="mb-4">
                            <div class="d-flex align-items-center mb-4">
                                <h4 class="fs-18 text-primary text-uppercase m-0">Tác giả hàng đầu</h4>
                                <hr class="m-0 ml-2">
                            </div>
                            <c:forEach var="item" items="${topUser}">
                                <c:set var="user" value="${item[0]}"/>
                                <c:set var="totalView" value="${item[1]}"/>
                                <c:set var="totalLike" value="${item[2]}"/>
                                <c:set var="totalPost" value="${item[3]}"/>

                                <div class="trand-right-single d-flex flex-column">
                                    <div class="d-flex">
                                        <a href="/users/wall/${user.ID}/${user.username}" class="block trand-right-img" style="height: 4rem; width: 4rem; flex-shrink: 0;">
                                            <c:choose>
                                                <c:when test="${empty user.avatar}">
                                                    <img src="/images/no-avatar.jpg" alt="avatar" class="rounded-circle avatar-image" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src='/getImage/${user.avatar}' alt="avatar" class="rounded-circle avatar-image" />
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                        <div class="trand-right-cap">
                                            <h4 class="mb-0">
                                                <a class="title-post" href="/users/wall/${user.ID}/${user.username}">
                                                    ${user.fullName == null or user.fullName == '' ? user.username : user.fullName}
                                                </a>
                                            </h4>
                                            <div class="mb-1">
                                                <a class="title-post" href="/users/wall/${user.ID}/${user.username}">
                                                    @${user.username}
                                                </a>
                                            </div>
                                            <!-- <div>
                                                <c:if test="${not empty authLogin}">
                                                    <c:if test="${authLogin.ID ne user.ID}">
                                                        <c:choose>
                                                            <c:when test="${isFollow eq true}">
                                                                <button data-type="1" class="btn-unfollow btn-follow btn button fs-14" style="padding: 13px;">
                                                                    <i class="fas fa-check"></i> Đang theo dõi
                                                                </button>
                                                                <button data-type="0" class="btn-isfollow btn-follow btn-line fs-14" style="height: 34px; display: none;">
                                                                    <i class="fas fa-plus"></i> Theo dõi
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button data-type="1" class="btn-unfollow btn-follow btn button fs-14" style="display: none; padding: 13px;">
                                                                    <i class="fas fa-check"></i> Đang theo dõi
                                                                </button>
                                                                <button data-type="0" class="btn-isfollow btn-follow btn-line fs-14" style="height: 34px;">
                                                                    <i class="fas fa-plus"></i> Theo dõi
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                </c:if>
                                            </div> -->
                                        </div>
                                    </div>
                                    <ul class="blog-info-link ml-2 mt-2">
                                        <li>
                                            <a href="#">
                                                <i class="mr-0 fas fa-user-plus"></i>
                                                ${user.totalFollow}
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <i class="mr-0 fas fa-eye"></i>
                                                ${totalView}
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <i class="mr-0 fas fa-thumbs-up"></i>
                                                ${totalLike}
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <div class="mb-4">
                            <div class="d-flex align-items-center mb-4">
                                <h4 class="fs-18 text-primary text-uppercase m-0">Bài viết nổi bật</h4>
                                <hr class="m-0 ml-2">
                            </div>
                            <c:forEach var="item" items="${topLike}">
                                <div class="trand-right-single d-flex">
                                    <div class="trand-right-img" style="height: 5rem; width: 5rem; flex-shrink: 0;">
                                        <c:choose>
                                            <c:when test="${empty item.avatar}">
                                                <c:choose>
                                                    <c:when test="${empty item.getUserID().avatar}">
                                                        <img src="/images/no-avatar.jpg" alt="avatar" class="rounded-circle avatar-image" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src='/getImage/${item.getUserID().avatar}' alt="avatar" class="rounded-circle avatar-image" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <img src='/getImage/${item.avatar}' alt="avatar" class="rounded-circle avatar-image" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="trand-right-cap">
                                        <h4 class="mb-1"><a class="title-post" href="/posts/${item.getID()}/${item.getSlug()}.html">${item.title}</a></h4>
                                        <!-- <span class="color1">Concert</span> -->
                                        <ul class="blog-info-link">
                                            <!-- <li>
                                                <a href="/posts/${item.getID()}/${item.getSlug()}.html" class="fs-12">
                                                    <i class="fas fa-calendar-alt"></i>
                                                    <fmt:formatDate value="${item.getCreateAt()}" pattern="dd-MM-yyyy" />
                                                </a>
                                            </li> -->
                                            <li>
                                                <a href="/posts/${item.getID()}/${item.getSlug()}.html" class="fs-12">
                                                    <i class="fas fa-eye"></i>
                                                    ${item.totalView}
                                                </a>
                                            </li>
                                            <li>
                                                <a href="/posts/${item.getID()}/${item.getSlug()}.html" class="fs-12">
                                                    <i class="fas fa-thumbs-up"></i>
                                                    ${item.totalLike}
                                                </a>
                                            </li>
                                            <li>
                                                <a href="/posts/${item.getID()}/${item.getSlug()}.html" class="fs-12">
                                                    <i class="fa fa-comments"></i>
                                                    ${item.totalComment}
                                                </a>
                                            </li>
                                        </ul>
                                        <ul class="blog-info-link">
                                            <li>
                                                <a href="/users/wall/${item.getUserID().ID}/${item.getUserID().username}">
                                                    <i class="fa fa-user"></i>
                                                    ${item.getUserID().fullName == null or item.getUserID().fullName == '' ? item.getUserID().username : item.getUserID().fullName}
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Trending Area End -->
    </main>
    
    <%@ include file="./layouts/footer.jsp" %>
        
    </body>
</html>
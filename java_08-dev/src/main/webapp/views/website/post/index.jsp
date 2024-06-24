<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html class="no-js" lang="zxx">
    <%@ include file="../layouts/head.jsp" %>
   <body>

    <%@ include file="../layouts/header.jsp" %>

    <main>
        <!--================Blog Area =================-->
    <section class="blog_area section-padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mb-5 mb-lg-0">
                    <div class="blog_left_sidebar">
                        <c:if test="${not empty posts.content}">
                            <c:forEach var="item" items="${posts.content}">
                                <article class="blog_item">
                                    <div class="p-3 d-flex blog_details">
                                        <div class="mr-3 py-2">
                                            <a class="d-block" href="/users/wall/${item.getUserID().ID}/${item.getUserID().username}" style="height: 3.5rem; width: 3.5rem;">
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

                            <!-- Hiển thị liên kết phân trang -->
                            <c:if test="${posts.totalPages > 1}">
                                <nav class="blog-pagination justify-content-center d-flex">
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
                </div>
                <div class="col-lg-4">
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
                                            <p>${category.getCategoryName()} </p>
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
                                    <a href="#">#Phần cứng</a>
                                </li>
                                <li>
                                    <a href="#">#Phần mềm</a>
                                </li>
                                <li>
                                    <a href="#">#Java</a>
                                </li>
                                <li>
                                    <a href="#">#Spring Boots</a>
                                </li>
                                <li>
                                    <a href="#">#PHP</a>
                                </li>
                                <li>
                                    <a href="#">#Asp.Net</a>
                                </li>
                                <li>
                                    <a href="#">Figma</a>
                                </li>
                                <li>
                                    <a href="#">Laravel</a>
                                </li>
                            </ul>
                        </aside>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================Blog Area =================-->
    </main>
    
    <%@ include file="../layouts/footer.jsp" %>
        
    </body>
</html>
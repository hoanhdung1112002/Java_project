<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html class="no-js" lang="zxx">
    <%@ include file="../layouts/head.jsp" %>
   <body style="background-color: #F0F2F5;">

    <%@ include file="../layouts/header.jsp" %>

    <main>
        <section class="blog_area section-padding">
            <div class="container">
                <div class="row">
                    <div class="col-lg-10 col-xl-8 mb-5 mx-auto">
                        <div class="blog_left_sidebar notify-wrapper">

                            <h1 class="fs-24 mb-3 fw-bold">Thông báo</h1>   

                            <c:if test="${not empty notifications.content}">
                                <c:forEach var="item" items="${notifications.content}">
                                    <div class="d-flex text-justify align-items-center p-2 notify-item">
                                        <div class="mr-3">
                                            <a class="d-block" href="/users/wall/${item.getUserSend().ID}/${item.getUserSend().username}" style="height: 4.1rem; width: 4.1rem;">
                                                <c:set var="avatar" value="${item.getUserSend().avatar}" />
                                                <c:choose>
                                                    <c:when test="${empty avatar}">
                                                        <img src="/images/no-avatar.jpg" alt="avatar"
                                                            class="rounded-circle avatar-notify avatar-image" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="/getImage/${avatar}" alt="avatar"
                                                            class="rounded-circle avatar-notify avatar-image" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                        </div>

                                        <c:choose>
                                            <c:when test="${item.type eq 0 or item.type eq 1}">
                                                <a class="d-flex flex-column" href="/posts/${item.getPostID().getID()}/${item.getPostID().getSlug()}.html">
                                                    <span class="m-0 notify-content">
                                                        <strong>
                                                            ${item.getUserSend().fullName == null or item.getUserSend().fullName == '' ? item.getUserSend().username : item.getUserSend().fullName}
                                                        </strong>
                                                        ${item.content}: <strong>${item.getPostID().title}</strong>
                                                    </span>
                                                    <span> ${item.convertCreatedAt()} </span>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${item.type eq 3}"> 
                                                        <a class="d-flex flex-column w-100" href="/users/wall/${item.getUserSend().ID}/${item.getUserSend().username}">
                                                            <span class="m-0 notify-content">
                                                                <strong>
                                                                    ${item.getUserSend().fullName == null or item.getUserSend().fullName == '' ? item.getUserSend().username : item.getUserSend().fullName}
                                                                </strong>
                                                                ${item.content}
                                                            </span>
                                                            <span> ${item.convertCreatedAt()} </span>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${item.type eq 4}"> 
                                                                <a class="d-flex flex-column w-100" href="/notify/details/${item.ID}">
                                                                    <span class="m-0 notify-content">
                                                                        <strong> Quản trị viên:  </strong>
                                                                        ${item.title}
                                                                    </span>
                                                                    <span> ${item.convertCreatedAt()} </span>
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a class="d-flex flex-column" href="#">
                                                                    <span class="m-0 notify-content">
                                                                        <strong>
                                                                            ${item.getUserSend().fullName == null or item.getUserSend().fullName == '' ? item.getUserSend().username : item.getUserSend().fullName}
                                                                        </strong>
                                                                        ${item.content}
                                                                    </span>
                                                                    <span> ${item.convertCreatedAt()} </span>
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>

                                <!-- Hiển thị liên kết phân trang -->
                                <c:if test="${notifications.totalPages > 1}">
                                    <nav class="blog-pagination justify-content-center d-flex">
                                        <ul class="pagination">
                                            <c:if test="${notifications.number > 0}">
                                                <li class="page-item">
                                                    <a href="?page=${notifications.number}" class="page-link" aria-label="Previous">
                                                        <i class="ti-angle-left"></i>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <c:forEach var="i" begin="1" end="${notifications.totalPages }">
                                                <c:if test="${i-1 != notifications.number}">
                                                    <li class="page-item">
                                                        <a href="?page=${i}" class="page-link">${i}</a>
                                                    </li>
                                                </c:if>
                                                <c:if test="${i-1 == notifications.number}">
                                                    <li class="page-item active">
                                                        <span class="page-link">${i}</span>
                                                    </li>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${notifications.number + 1 ne notifications.totalPages}">
                                                <li class="page-item">
                                                    <a href="?page=${notifications.number+2}" class="page-link" aria-label="Next">
                                                        <i class="ti-angle-right"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </c:if>
                            </c:if>
                            
                            <c:if test="${empty notifications.content}">
                                <p class="text-center py-3">Không có thông báo</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <%@ include file="../layouts/footer.jsp" %>
    </body>
</html>
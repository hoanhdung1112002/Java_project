<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="loader"></div>
<header>
    <!-- Header Start -->
   <div class="header-area">
        <div class="main-header ">
            <div class="header-mid py-3 d-none d-md-block">
               <div class="container">
                    <div class="row d-flex align-items-center">
                        <!-- Logo -->
                        <div class="col-xl-3 col-lg-3 col-md-3">
                            <div class="logo">
                                <a href="/"><img style="max-width: 80px;" src="/images/logo/logo.png" alt=""></a>
                            </div>
                        </div>
                        <div class="col-xl-9 col-lg-9 col-md-9 d-flex justify-content-end">
                            <form action="/posts/search" class="w-50" style="max-width: 400px;">
                                <div class="form-group m-0 h-100 mr-4">
                                    <div class="input-group m-0 h-100">
                                        <input type="text" name="search" class="form-control h-100" placeholder='Từ khóa cần tìm' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Từ khóa cần tìm'">
                                        <div class="input-group-append">
                                            <button class="btn px-3 py-0" style="min-width: 30px;" type="submit"><i class="ti-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <c:choose>
                                <c:when test="${not empty authLogin}">
                                    <div class="d-flex align-items-center header-auth">
                                        <div class="fs-24 text-light">
                                            <a href="/messages" class="icon-in-menu mr-2" style="padding: 4px 0 4px 4px;">
                                                <i class="far fa-envelope"></i>
                                                <c:if test="${countUnread ne 0}">
                                                    <span class="dot-messages">${countUnread}</span>
                                                </c:if>
                                            </a>
                                            <a href="/notify" class="icon-in-menu mr-2" style="padding: 4px 6.48px;">
                                                <i class="far fa-bell"></i>
                                                <span class="dot"></span>
                                            </a>
                                        </div>
                                        <div class="d-flex align-items-center hover-action">
                                            <span class="d-none d-md-block ps-2"> ${authLogin.fullName} </span>
                                            <div class="ml-2" style="height: 2.5rem; width: 2.5rem;">
                                                <c:set var="avatar" value="${authLogin.avatar}" />
                                                <c:choose>
                                                    <c:when test="${empty avatar}">
                                                        <img class="rounded-circle avatar-image" src="/images/no-avatar.jpg" alt="avatar"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="rounded-circle avatar-image" src="/getImage/${avatar}" alt="avatar"/>
                                                    </c:otherwise>
                                                </c:choose>
    
                                                <div class="action-wrapper">
                                                    <ul class="list-action">
                                                        <li>
                                                            <a href="/users/profile" class="link">
                                                                <i style="width: 18px;" class="far fa-user"></i>
                                                                Trang cá nhân
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="/posts/create" class="link d-block d-lg-none">
                                                                <i style="width: 18px;" class="far fa-clipboard"></i>
                                                                Đăng bài viết
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="/users/profile" class="link">
                                                                <i style="width: 18px;" class="far fa-clipboard"></i>
                                                                Quản lý bài viết
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="/notify" class="link">
                                                                <i style="width: 18px;" class="far fa-bell"></i>
                                                                Thông báo
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="/auth/logout" class="link">
                                                                <i style="width: 18px;" class="fas fa-sign-out-alt"></i>
                                                                Đăng xuất
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <a href="/auth/register" class="black-color px-2">
                                        <span class="d-block px-2 text-uppercase" style="line-height: 40px;">
                                            Đăng ký
                                        </span>
                                        <hr class="h-hr-3">
                                    </a>
                                    <a href="/auth/login" class="ml-3 button btn">
                                        Đăng nhập
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
               </div>
            </div>
           <div class="header-bottom header-sticky">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-10 col-12 header-flex">
                            <!-- sticky -->
                            <div class="sticky-logo">
                                <a href="/"><img style="max-width: 80px;" src="/images/logo/logo.png" alt=""></a>
                            </div>
                            <!-- Main-menu -->
                            <div class="main-menu d-none d-md-block">
                                <nav>                  
                                    <ul id="navigation">
                                        <li><a href="/">Trang chủ</a></li>
                                        <c:if test="${not empty authLogin}">
                                            <li><a href="/posts/followings">Đang theo dõi</a></li>
                                        </c:if>
                                        <li class="d-block d-md-none"><a href="/posts/create">Đăng bài viết</a></li>
                                        <c:forEach var="category" items="${categories}">
                                            <c:if test="${category.getLevel() eq 1}">
                                                <li>
                                                    <a href="<c:url value='/posts/category/'/>${category.getID()}">
                                                        <c:out value="${category.getCategoryName()}"/>
                                                    </a>

                                                    <ul class="submenu">
                                                        <c:forEach var="subCategory" items="${categories}">
                                                            <c:if test="${subCategory.getLevel() eq 2 and subCategory.getParentID() eq category.getID()}">
                                                                <li class="m-0">
                                                                    <a href="<c:url value='/posts/category/'/>${subCategory.getID()}">
                                                                        <c:out value="${subCategory.getCategoryName()}"/>
                                                                    </a>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <c:if test="${not empty authLogin}">
                            <div class="col-lg-2 d-none d-lg-block">
                                <div>
                                    <a href="/posts/create" class="btn-line">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                            <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"></path>
                                        </svg>
                                        Viết bài
                                    </a>
                                </div>
                            </div>             
                        </c:if>
                        <!-- Mobile Menu -->
                        <div class="col-12">
                            <div class="mobile_menu d-block d-md-none"></div>
                        </div>
                    </div>
                </div>
           </div>
        </div>
   </div>
    <!-- Header End -->
</header>
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

            <div class="blog_details pt-0">
                <h2 class="fs-20">
                    ${notification.title}
                </h2>
                <ul class="blog-info-link mt-3 mb-4">
                    <li>
                        Tạo bởi quản trị viên ${notification.convertCreatedAt()} 
                    </li>
                </ul>
                <div class="w-100 pb-3 text-justify">
                    ${notification.content}
                </div>
            </div>
        </div>
    </section>
    <%@ include file="../layouts/footer.jsp" %>
    </body>
</html>
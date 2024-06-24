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
                <div class="row no-gutters chat-main">
                    <div class="col-3 col-md-5 col-xl-4">
                        <div class="blog_left_sidebar chat-wrapper w-100 pr-1">
                            <h1 class="d-none d-md-block fs-24 mb-3 fw-bold">Đoạn chat</h1>   
                            <h1 class="d-block d-md-none fs-20 mb-3 fw-bold">Chat</h1>   

                            <div class="overflow-y-auto scroll-custom pr-2" style="height: 62vh;">
                                <c:if test="${not empty rooms}">
                                    <c:forEach var="item" items="${rooms}">
                                        <c:set var="room" value="${item[0]}"/>
                                        <c:set var="messages" value="${item[1]}"/>
                                        <div style="padding: 0.6rem !important;"
                                            class='d-flex text-justify align-items-center p-2 justify-content-center justify-content-md-start position-relative chat-item notify-item ${room.code eq code ? "active" : ""}'>
                                            <div class="mr-0 mr-md-3" onclick="location.href = '/messages/${room.code}'">
                                                <div class="d-block" style="height: 3.5rem; width: 3.5rem;">
                                                    <c:choose>
                                                        <c:when test="${authLogin.ID eq room.userRoom.ID}">
                                                            <c:set var="avatar" value="${room.userCreate.avatar}"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="avatar" value="${room.userRoom.avatar}"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:choose>
                                                        <c:when test="${empty avatar}">
                                                            <img src="/images/no-avatar.jpg" alt="avatar"
                                                                class="rounded-circle avatar-notify avatar-image"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="/getImage/${avatar}" alt="avatar"
                                                                class="rounded-circle avatar-notify avatar-image"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
    
                                            <div class="flex-column d-none d-md-flex" onclick="location.href = '/messages/${room.code}'" style="width: 78%;">
                                                <span class="m-0 notify-content">
                                                    <c:choose>
                                                        <c:when test="${authLogin.ID eq room.userRoom.ID}">
                                                            <strong>
                                                                ${room.userCreate.fullName == null or room.userCreate.fullName == '' ? room.userCreate.username : room.userCreate.fullName}
                                                            </strong>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <strong>
                                                                ${room.userRoom.fullName == null or room.userRoom.fullName == '' ? room.userRoom.username : room.userRoom.fullName}
                                                            </strong>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <div class="d-flex fs-14 align-items-center w-100">
                                                    <c:choose>
                                                        <c:when test="${empty messages.ID}">
                                                            <span style="font-weight: 300; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
                                                                Chat với 
                                                                <c:choose>
                                                                    <c:when test="${authLogin.ID eq room.userRoom.ID}">
                                                                        ${room.userCreate.fullName == null or room.userCreate.fullName == '' ? room.userCreate.username : room.userCreate.fullName}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${room.userRoom.fullName == null or room.userRoom.fullName == '' ? room.userRoom.username : room.userRoom.fullName}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                ngay nào
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span style="font-weight: 300; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"> 
                                                                <c:choose>
                                                                    <c:when test="${authLogin.ID eq messages.userID.ID}">
                                                                        Bạn: ${messages.content} 
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <c:choose>
                                                                            <c:when test="${empty messages.viewDate}">
                                                                                <strong style="font-weight: 500;">${messages.content}</strong>
                                                                                <div class="position-absolute dot"><i class="fs-12 fas fa-circle"></i></div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                ${messages.content} 
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </span> 
                                                            <i style="font-size: 4px;" class="mx-2 fas fa-circle"></i>
                                                            <span class="flex-lg-shrink-0" style="font-weight: 300; text-wrap: nowrap;">
                                                                ${messages.convertCreatedAt()}
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
    
                                            <div class="dropdown position-absolute" style="top: 0; right: 0;">
                                                <button class="btn-text" type="button" data-toggle="dropdown" aria-expanded="false" style="padding: 4px 12px !important;">
                                                    <i class="fs-16 fas fa-ellipsis-h"></i>
                                                </button>
                                                <div class="dropdown-menu dropdown-menu-right">
                                                    <a data-id="${room.ID}" class="dropdown-item btn-delete-data">
                                                        <i style="width: 18px;" class="far fa-trash-alt"></i>
                                                        Xóa đoạn chat
                                                    </a>
                                                </div>
                                            </div>
    
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            
                            <c:if test="${empty rooms}">
                                <p class="text-center py-3">Chưa có đoạn chat nào</p>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-9 col-md-7 col-xl-8 mx-auto">
                        <div class="blog_left_sidebar h-100 w-100 p-0">
                            <c:if test="${not empty messagesList or not empty code}">
                                <div class="w-100 pb-2" style="overflow: hidden;">
                                    <div class='d-flex text-justify align-items-center p-2' style="box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);">
                                        <c:if test="${not empty user}">
                                            <div class="mr-3">
                                                <a href="/users/wall/${user.ID}/${user.username}" class="d-block" style="height: 2.6rem; width: 2.6rem;">
                                                    <c:set var="avatarUser" value="${user.avatar}"/>
                                                    <c:choose>
                                                        <c:when test="${empty avatarUser}">
                                                            <img src="/images/no-avatar.jpg" alt="avatar"
                                                                class="rounded-circle avatar-notify avatar-image"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="/getImage/${avatarUser}" alt="avatar"
                                                                class="rounded-circle avatar-notify avatar-image"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </div>
                                            <div class="d-flex flex-column">
                                                <a href="/users/wall/${user.ID}/${user.username}" class="m-0 notify-content">
                                                    ${user.fullName == null or user.fullName == '' ? user.username : user.fullName}
                                                </a>
                                            </div>
                                        </c:if>
                                    </div>

                                    <div id="messages-list" class="p-3 overflow-y-auto scroll-custom" style="height: 50vh;">
                                        <c:forEach var="messagesItem" items="${messagesList}">
                                            <c:choose>
                                                <c:when test="${authLogin.ID ne messagesItem.userID.ID}">
                                                    <c:set var="avatar" value="${messagesItem.userID.avatar}"/>
        
                                                    <div class="mb-3 d-flex align-items-end">
                                                        <!-- UserInbox -->
                                                        <div class="d-block mr-2" style="height: 2.4rem; width: 2.4rem;">
                                                            <c:choose>
                                                                <c:when test="${empty avatar}">
                                                                    <img src="/images/no-avatar.jpg" alt="avatar"
                                                                        class="rounded-circle avatar-notify avatar-image"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="/getImage/${avatar}" alt="avatar"
                                                                        class="rounded-circle avatar-notify avatar-image"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="message-item">
                                                            <span>
                                                                ${messagesItem.content}
                                                            </span>
                                                            <div class="fs-12 messages-view-date position-absolute">
                                                                Đã gửi
                                                                <fmt:formatDate value="${messagesItem.getCreatedAt()}" pattern="dd-MM-yyyy" /> lúc
                                                                <fmt:formatDate value="${messagesItem.getCreatedAt()}" pattern="HH:mm" />
                                                            </div>
                                                        </div>
                                                    </div>
        
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="mb-3 d-flex justify-content-end align-items-center">
                                                        <div class="message-item message-item-my">
                                                            <span>
                                                                ${messagesItem.content}
                                                            </span>
                                                            <div class="fs-12 messages-view-date date-right position-absolute">
                                                                Đã gửi
                                                                <fmt:formatDate value="${messagesItem.getCreatedAt()}" pattern="dd-MM-yyyy" /> lúc
                                                                <fmt:formatDate value="${messagesItem.getCreatedAt()}" pattern="HH:mm" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                                
                                <div class="p-3 pt-2">
                                    <form id="form-send" method="POST" action="/messages/send/${code}" enctype="multipart/form-data" class="h-100">
                                        <div class="d-flex justify-content-end position-relative">
                                            <div class="d-flex align-items-end mb-1">
                                                <i class="fs-20 mr-2 far fa-images"></i>
                                                <i class="fs-20 ml-2 fas fa-smile"></i>
                                            </div>
                                            <textarea placeholder="Nhập nội dung tin nhắn" class="mx-3 form-control" name="content" id="content" required></textarea>
                                            <div class="d-flex align-items-end">
                                                <button type="submit" class="btn-text btn-send-messages button">
                                                    <i class="fas fa-paper-plane"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </c:if>
                            <c:if test="${empty messagesList and empty code}">
                                <div class="w-100 h-100 d-flex align-items-center justify-content-center flex-column">
                                    <i data-visualcompletion="css-img" style="background-image: url(&quot;https://static.xx.fbcdn.net/rsrc.php/v3/yf/r/QG6amnX3-8_.png?_nc_eui2=AeH_Db0hfFeyark8obO8n-War-W6yK7dVLuv5brIrt1Uu996MSHTLrhXjxvligJmYs7pLUXov73m2HgEDn4c4aXF&quot;); background-position: 0px -182px; background-size: 248px 386px; width: 244px; height: 180px; background-repeat: no-repeat; display: inline-block;"></i>
                                    <strong class="text-center pb-4 mb-4">Chưa chọn đoạn chat nào</strong>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="../layouts/footer.jsp" %>
    <script>
        $(document).ready(function() {
            const messagesList = $('#messages-list');

            if (messagesList.length > 0) {
                messagesList.scrollTop(messagesList[0].scrollHeight);
            }

            // Check value when submit form
            $("#form-send").on("submit", () => {
                const content = $('#content').val();
                if (content.trim() === '') {
                    showMessage("error", "Nội dung tin nhắn không được để trống !");
                    return false;
                }
                return true;
            });

            //Handle delete room
            $(document).on('click', '.btn-delete-data', function(e) {
                const id = $(this).data('id');

                Swal.fire({
                    icon: 'question',
                    text: "Dữ liệu sẽ không thể khôi phục",
                    showCancelButton: true,
                    confirmButtonText: 'Xác nhận',
                    cancelButtonText: 'Hủy bỏ',
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "GET",
                            url: `/room/delete/` + id,
                        }).done(function(response) {
                            location.href = "/messages"
                        }).fail(function(xhr, status, error) {
                            showMessage("error");
                        });
                    }
                });
            });
        });
    </script>
    </body>
</html>
<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/png" href="">
    <title>Hello</title>

    <!-- Google Web Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <script src="https://kit.fontawesome.com/697be04d3d.js" crossorigin="anonymous"></script>

    <!-- Load library -->
    <script src="/js/libs/jquery-3.6.1.min.js"></script>
    <script src="/js/libs/select2.min.js"></script>
    <script src="/js/libs/sweetalert.min.js"></script>
    <script src="/vendor/DataTables/datatables.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <!-- Vendor CSS Files -->
    <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/vendor/DataTables/datatables.min.css" rel="stylesheet">
    <link href="/css/libs/select2.min.css" rel="stylesheet">
    <link href="/css/libs/sweetalert.css" rel="stylesheet">
    <link href="https://code.jquery.com/ui/1.13.0/themes/smoothness/jquery-ui.css" rel="stylesheet" >
    <!-- Css global -->
    <link href="/css/style.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet">
    <link href="/css/login.css" rel="stylesheet">
</head>

<body>
    <div class="main-login">
        <div class="main-login-cover">
            <img src="/images/bg-login.jpg" alt="Cover">
        </div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 p-2 p-sm-2 carts" style="max-width: 450px;">
                    <div class="card">
                        <div class="card-body py-3 px-0 py-sm-5 px-sm-4">
                            <div class="text-center pb-2 mb-5 mt-3">
                                <img style="max-width: 120px;" src="/images/logo/logo.png" alt="Logo">
                            </div>

                            <form class="container" method="POST" action="/auth/register">
                                <div class="input-group mb-3">
                                    <div class="input-group-append"><span class="input-group-text"><i class="fas fa-user"></i></span></div>
                                    <input id="username" type="text" name="username" class="form-control" placeholder="Tên tài khoản" required>
                                </div>

                                <div class="input-group mb-3">
                                    <div class="input-group-append"><span class="input-group-text"><i class="fas fa-at"></i></span></div>
                                    <input id="email" type="text" name="email" class="form-control" placeholder="Địa chỉ email" required>
                                </div>

                                <div class="input-group mb-3">
                                    <div class="input-group-append"><span class="input-group-text"><i class="fas fa-key"></i></span></div>
                                    <input id="password" type="password" name="password" class="form-control" placeholder="Mật khẩu" required>
                                </div>

                                <div class="input-group mb-4">
                                    <div class="input-group-append"><span class="input-group-text"><i class="fas fa-key"></i></span></div>
                                    <input id="password_confirm" type="password" name="password_confirm" class="form-control" placeholder="Xác nhận mật khẩu" required>
                                </div>

                                <c:if test="${not empty error}">
                                    <div class="text-center my-3 text-danger">
                                        <c:out value="${error}" />
                                    </div>
                                </c:if>

                                <div class="row mb-0 mt-4 btn-offset-parent">
                                    <div class="col-md-12 offset-md-4 btn-offset-children">
                                        <button type="submit" class="btn py-3 btn-primary w-100 py-2">
                                            Đăng ký
                                        </button>
                                    </div>
                                    <div class="mt-3 text-center">
                                        <span>Đã có tài khoản</span>
                                        <a class="text-primary" href="/auth/login">Đăng nhập</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

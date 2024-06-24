<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html class="no-js" lang="zxx">
    <%@ include file="../website/layouts/head.jsp" %>
   <body>

    <%@ include file="../website/layouts/header.jsp" %>

    <main>
        <section class="py-5 my-4">
            <div class="container p-4">
                <div class="row">
                    <div class="col-12 text-center">
                        <h2>401 - AUTHENTICATE</h2>
                        <p class="text-danger">
                            Chỉ quản trị viên mới có thể truy cập trang quản trị
                        </p>
                    </div>
                </div>
            </div>
        </section>
        <!--================Blog Area =================-->
    </main>
    
    <%@ include file="../website/layouts/footer.jsp" %>
        
    </body>
</html>
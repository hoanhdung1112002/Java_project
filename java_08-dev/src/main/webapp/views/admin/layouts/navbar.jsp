<!-- Navbar -->
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-item">
            <a class="nav-link collapsed" href="/admin/statistical">
                <i class="bi bi-graph-up-arrow"></i>
                <span>Thống kê</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="/admin/users">
                <i class="bi bi-people"></i>
                <span>Quản lý người dùng</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="/admin/categories">
                <i class="bi bi-layout-text-sidebar"></i>
                <span>Quản lý danh mục</span>
            </a>
        </li>
        <!-- <li class="nav-item">
            <a class="nav-link collapsed" href="/admin/categories">
                <i class="bi bi-tags"></i>
                <span>Quản lý thẻ</span>
            </a>
        </li> -->
        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#Menu1"
                data-bs-toggle="collapse">
                <i class="bi bi-file-earmark-post"></i></i><span>Quản lý bài viết</span><i
                    class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="Menu1" class="nav-content collapse " data-bs-parent="#sidebar-nav">
                <li>
                    <a href="/admin/posts">
                        <i class="bi bi-circle"></i><span>Danh sách bài viết</span>
                    </a>
                </li>
                <li>
                    <a href="/admin/report/posts">
                        <i class="bi bi-circle"></i><span>Bài viết bị báo cáo</span>
                    </a>
                </li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="/admin/notify">
                <i class="bi bi-bell"></i>
                <span>Quản lý thông báo</span>
            </a>
        </li>
    </ul>
</aside><!-- End Sidebar-->
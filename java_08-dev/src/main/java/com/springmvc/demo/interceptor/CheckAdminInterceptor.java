package com.springmvc.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class CheckAdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
        throws Exception {
            HttpSession session = request.getSession();
            Integer role = (Integer) session.getAttribute("role");
            if (role != null) {
                if (role == 0) return true;
            }
            response.sendRedirect(request.getContextPath() + "/error/401.html");
            return false;
    }
}

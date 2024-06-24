package com.springmvc.demo.Utilities;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.springmvc.demo.interceptor.CheckAdminInterceptor;
import com.springmvc.demo.interceptor.LoginInterceptor;


@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public LoginInterceptor loginInterceptor() {
        return new LoginInterceptor();
    }

    @Bean
    public CheckAdminInterceptor checkAdminInterceptor() {
        return new CheckAdminInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor())
            .addPathPatterns("/users/profile/**", "/posts/create", "/posts/edit/**", "/admin/**", "/messages/**");
        registry.addInterceptor(checkAdminInterceptor())
            .addPathPatterns("/admin/**");
    }
}
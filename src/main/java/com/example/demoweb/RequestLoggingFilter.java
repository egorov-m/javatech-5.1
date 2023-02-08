package com.example.demoweb;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.demoweb.service.UserService;

@WebFilter("/*")
public class RequestLoggingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = false;
        if (session != null) {
            Object login = session.getAttribute("login");
            Object password = session.getAttribute("password");
            if (login != null && password != null) {
                UserService userService = new UserService();
                isLoggedIn = userService.validUser(login.toString(), password.toString());
            }
        }

        String URI = httpRequest.getContextPath() + "/files";
        String loginURI = URI + "/login";
        String regURI = URI + "/signup";

        boolean isLoginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean isRegRequest = httpRequest.getRequestURI().equals(regURI);

        if (isRegRequest) {
            // переход на страницу регистрации
            chain.doFilter(request, response);
        } else if (isLoggedIn && isLoginRequest) {
            // попытка повторного перехода на страницу авторизации
            httpResponse.sendRedirect(URI);
        } else if (isLoggedIn || isLoginRequest) {
            // пользователь уже вошёл в профиль или перешёл на страницу входа
            chain.doFilter(request, response); // продолжаем цепочку фильтров, позволяя достичь адреса
        } else {
            // пользователь не вошёл в систему, требуется аутентификация
            httpResponse.sendRedirect(loginURI);
        }
    }
}

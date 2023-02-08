package com.example.demoweb;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.demoweb.service.UserService;

@WebServlet("/files/signup")
public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String param = req.getParameter("error");
        boolean isError = param != null && param.equals("true");
        if (isError) {
            req.setAttribute("visibilityError", "block");
            req.setAttribute("errorText", "Error. Such a user cannot be registered.");
        }

        req.getRequestDispatcher("../registrationServlet.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (login != null && email != null && password != null) {
            UserService userService = new UserService();
            try {
                userService.addUser(login, email, password);
                resp.sendRedirect("./login");
            } catch (IllegalArgumentException e) {
                resp.sendRedirect(req.getContextPath() + req.getServletPath() + "?error=true");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + req.getServletPath() + "?error=true");
        }
    }
}

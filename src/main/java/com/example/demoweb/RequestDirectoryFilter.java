package com.example.demoweb;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = { "/files", "/files/download" })
public class RequestDirectoryFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String item = request.getParameter("path");

        if (item != null) {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            HttpSession session = httpRequest.getSession(false);

            String path;
            if (httpRequest.getMethod().equals("POST")) {
                byte[] bytes = item.getBytes(StandardCharsets.ISO_8859_1);
                path = new String(bytes, StandardCharsets.UTF_8);
            } else {
                path = item;
            }

            if (session != null) {
                String home = System.getProperty("user.home");
                Object login = session.getAttribute("login");
                String basePath = home + File.separator + login.toString();
                if (isSubDirectory(new File(basePath), new File(path))) {
                    chain.doFilter(request, response);
                } else {
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/files");
                }
            }
        } else {
            chain.doFilter(request, response);
        }
    }

    public boolean isSubDirectory(File base, File child) throws IOException {
        base = base.getCanonicalFile();
        child = child.getCanonicalFile();

        File parentFile = child;
        while (parentFile != null) {
            if (base.equals(parentFile)) {
                return true;
            }
            parentFile = parentFile.getParentFile();
        }
        return false;
    }
}

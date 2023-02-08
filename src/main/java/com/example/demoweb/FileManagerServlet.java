package com.example.demoweb;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/files")
public class FileManagerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Время генерации страницы
        String date = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss").format(LocalDateTime.now());
        ZoneId timeZone = ZoneId.systemDefault();
        req.setAttribute("date", date);
        req.setAttribute("timeZone", timeZone);

        // Текущая отображаемая директория
        String path = req.getParameter("path");
        if (path == null) {
            HttpSession session = req.getSession();
            path = System.getProperty("user.home");
            if (session != null) {
                Object login = session.getAttribute("login");
                if (login != null) {
                    path = path + File.separator + login.toString();
                } else {
                    path = path + File.separator + "default";
                }
            } else {
                path = path + File.separator + "default";
            }
            resp.sendRedirect(String.format("%s%s?path=%s", req.getContextPath(), req.getServletPath(), URLEncoder.encode(path, StandardCharsets.UTF_8.toString())));
            return;
        }
        req.setAttribute("path", path);

        // Переход к родительской директории
        String directorateAtTheTop = new File(path).getParent();
        if (directorateAtTheTop != null) {
            req.setAttribute("directoryVisibilityOnTop", "block");
            req.setAttribute("directorateAtTheTop", directorateAtTheTop);
        } else {
            req.setAttribute("directoryVisibilityOnTop", "none");
        }

        // Таблица с содержимым текущей директории
        outputContentsDir(req, path);

        req.getRequestDispatcher("fileManagerServlet.jsp").forward(req, resp);
    }

    private void outputContentsDir(HttpServletRequest req, String path) {
        File f = new File(path);
        File[] allFiles = f.listFiles();

        if (allFiles != null) {
            List<File> directories = new ArrayList<>();
            List<File> files = new ArrayList<>();

            for (File file : allFiles) {
                if (file.getPath() != null) {
                    if (file.isDirectory())
                        directories.add(file);
                    else
                        files.add(file);
                }
            }

            req.setAttribute("directories", directories);
            req.setAttribute("files", files);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().write("POST method isn't available");
    }
}

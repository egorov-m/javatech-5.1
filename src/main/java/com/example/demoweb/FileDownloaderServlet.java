package com.example.demoweb;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/files/download")
public class FileDownloaderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().write("GET method isn't available");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String item = req.getParameter("path"); 

        if (item != null) {
            byte[] bytes = item.getBytes(StandardCharsets.ISO_8859_1);
            String path = new String(bytes, StandardCharsets.UTF_8);
            String fileName = Paths.get(path).getFileName().toString();
            resp.setContentType("application/x-msdownload");
            resp.setHeader("Content-Disposition", "attachment; filename="+ fileName);
            try (InputStream in = new FileInputStream(path); OutputStream out = resp.getOutputStream()) {
                byte[] buffer = new byte[1048];

                int numBytesRead;
                while ((numBytesRead = in.read(buffer)) > 0) {
                    out.write(buffer, 0, numBytesRead);
                }
            } catch (FileNotFoundException e) {
                resp.sendError(404);
            }

        resp.sendRedirect(req.getRequestURI());
        } else {
            resp.sendError(404);
        }
    }
}

<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.nio.file.Files,java.io.File" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>File Manager</title>
    <style>
      .table__row {
        text-align: -webkit-left;
        text-align: -moz-left;
        text-align: -o-left;
        text-align: -ms-left;
        text-align: left;
      }
      .table__row:hover {
        background: #f0f0f0;
      }
      .cuttedText {
        display: block;
        max-width: 220px;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
      }
    </style>
  </head>
  <body>
    <p>${date} ${timeZone}</p>
    <h1>${path}</h1>
    <hr />

    <form
      style="display: ${directoryVisibilityOnTop};"
      action="./files"
      method="get"
    >
      <button type="submit" name="path" value="${directorateAtTheTop}">
        <span class="cuttedText">⬆️ Вверх</span>
      </button>
    </form>

    <table>
      <tr class="table__row">
        <th><span class="cuttedText">Файл</span></th>
        <th><span class="cuttedText">Размер</span></th>
        <th><span class="cuttedText">Дата</span></th>
      </tr>

      <form action="./files" method="get">
        <c:forEach var="directory" items="${directories}">
          <tr class="table__row">
            <td>
              <button
                type="submit"
                name="path"
                value="${directory.getAbsolutePath()}"
              >
                <span class="cuttedText">📁 ${directory.getName()}/</span>
              </button>
            </td>
            <td><span class="cuttedText"></span></td>
            <td>
              <span class="cuttedText"
                >${Files.getAttribute(directory.toPath(),
                "lastModifiedTime").toString()}</span
              >
            </td>
          </tr>
        </c:forEach>
      </form>

      <form action="./files/download" method="post">
        <c:forEach var="file" items="${files}">
          <tr class="table__row">
            <td>
              <button type="submit" name="path" value="${file.getPath()}">
                <span class="cuttedText">📄 ${file.getName()}</span>
              </button>
            </td>
            <td>
              <span class="cuttedText">${Files.size(file.toPath())} B</span>
            </td>
            <td>
              <span class="cuttedText"
                >${Files.getAttribute(file.toPath(),
                "lastModifiedTime").toString()}</span
              >
            </td>
          </tr>
        </c:forEach>
      </form>
    </table>
  </body>
</html>

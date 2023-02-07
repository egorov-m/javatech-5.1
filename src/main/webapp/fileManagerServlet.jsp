<%@ page language="java" contentType="text/html; charset=UTF-8"
import="java.nio.file.Files,java.io.File" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>File Manager</title>
    <style>
      :root {
        --color-btn-primary-text: #fff;
        --color-btn-primary-bg: #238636;
        --color-btn-hover-primary-bg: #862323;
        --color-btn-primary-border: rgba(240, 246, 252, 0.1);
        --color-btn-primary-shadow: transparent;
        --color-btn-primary-inset-shadow: transparent;
      }

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

      .logout-form {
        position: fixed;
        right: 8px;
        top: 8px;
      }

      .btn {
        position: relative;
        display: inline-block;
        padding: 5px 16px;
        font-size: 14px;
        font-weight: 500;
        line-height: 20px;
        white-space: nowrap;
        vertical-align: middle;
        cursor: pointer;
        -webkit-user-select: none;
        user-select: none;
        border: 1px solid;
        border-radius: 6px;
        -webkit-appearance: none;
        appearance: none;
      }

      .btn-primary {
        color: var(--color-btn-primary-text);
        background-color: var(--color-btn-primary-bg);
        border-color: var(--color-btn-primary-border);
        box-shadow: var(--color-btn-primary-shadow),
          var(--color-btn-primary-inset-shadow);
      }

      .btn-primary:hover {
        background-color: var(--color-btn-hover-primary-bg);
        transition: 0.5s;
      }

      .btn-block {
        display: block;
        width: 100%;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <form
      class="logout-form"
      action="./files/logout"
      accept-charset="UTF-8"
      method="post"
    >
      <button type="submit" class="btn btn-primary btn-block" role="menuitem">
        Sign out
      </button>
    </form>

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

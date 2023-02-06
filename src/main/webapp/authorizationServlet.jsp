<%@ page language="java" contentType="text/html; charset=UTF-8"
import="java.nio.file.Files,java.io.File" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign in to File Manager</title>
    <style>
      :root {
        --color-btn-primary-text: #fff;
        --color-btn-primary-bg: #238636;
        --color-btn-primary-border: rgba(240, 246, 252, 0.1);
        --color-btn-primary-shadow: transparent;
        --color-btn-primary-inset-shadow: transparent;
        --color-fg-default: #24292f;
        --color-canvas-default: #fff;
        --color-border-default: #d0d7de;
        --color-primer-shadow-inset: transparent;
        --color-canvas-subtle: #f6f8fa;
        --color-border-muted: #d8dee4;
        --color-accent-fg: #0969da;
        --color-danger-subtle: rgba(248, 81, 73, 0.15);
        --color-danger-muted: rgba(248, 81, 73, 0.4);
      }

      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans",
          Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
        font-size: 14px;
        line-height: 1.5;
        color: var(--color-fg-default);
        background-color: var(--color-canvas-default);
      }

      a {
        color: var(--color-accent-fg);
        text-decoration: none;
      }

      a:hover {
        text-decoration: underline;
      }

      h1 {
        font-size: 24px;
        font-weight: 300;
        letter-spacing: -0.5px;
      }

      .flash {
        padding: 16px;
        margin: 0px auto 8px;
        font-size: 14px;
        border-style: solid;
        border-width: 1px;
        border-radius: 6px;
      }

      .flash-error {
        background-color: var(--color-danger-subtle);
        border-color: var(--color-danger-muted);
        color: var(--color-fg-default);
      }

      .auth-form {
        display: block;
        width: 340px;
        margin: 0px auto;
      }

      .auth-form-header {
        margin-bottom: 16px;
        color: var(--color-fg-default);
        text-align: center;
        text-shadow: none;
        background-color: transparent;
        border: 0;

        margin: 0;
        border-radius: 6px 6px 0 0;

        font-size: 24px;
        font-weight: 300;
        letter-spacing: -0.5px;
      }

      .auth-form-body {
        padding: 16px;
        font-size: 14px;
        background-color: var(--color-canvas-subtle);
        border: 1px solid var(--color-border-muted);
        border-top: 0;
        border-radius: 6px;

        margin-top: 4px;
        margin-bottom: 16px;
      }

      .form-control {
        padding: 5px 12px;
        font-size: 14px;
        line-height: 20px;
        color: var(--color-fg-default);
        vertical-align: middle;
        background-color: var(--color-canvas-default);
        background-repeat: no-repeat;
        background-position: right 8px center;
        border: 1px solid var(--color-border-default);
        border-radius: 6px;
        box-shadow: var(--color-primer-shadow-inset);
        transition: 80ms cubic-bezier(0.33, 1, 0.68, 1);
        transition-property: color, background-color, box-shadow, border-color;
      }

      .form-control:focus-visible {
        border-color: var(--color-accent-fg);
        outline: none;
        box-shadow: inset 0 0 0 1px var(--color-accent-fg);
      }

      .input-block {
        margin-top: 4px;
        margin-bottom: 16px;
        display: block;
        width: 100%;
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

      .btn-block {
        display: block;
        width: 100%;
        text-align: center;
      }

      .login-callout {
        padding: 16px 16px;
        text-align: center;
        border: 1px solid var(--color-border-default);
        border-radius: 6px;
      }
    </style>
  </head>
  <body>
    <main>
      <div class="auth-form">
        <div class="auth-form-header">
          <h1>Sign in to File Manager</h1>
        </div>

        <div
          class="flash flash-full flash-error"
          style="display:${visibilityError != null ? visibilityError : 'none'};"
        >
          <div aria-atomic="true" role="alert">
            ${errorText != null ? errorText : ""}
          </div>
        </div>

        <div class="auth-form-body">
          <form action="./login" method="post" accept-charset="UTF-8">
            <label for="login_field">Login</label>
            <input
              type="text"
              name="login"
              id="login_field"
              class="form-control input-block"
              autocapitalize="off"
              autocorrect="off"
              autocomplete="username"
              autofocus="autofocus"
              value="${login != null ? login : ''}"
            />

            <label for="password">Password</label>
            <input
              type="password"
              name="password"
              id="password"
              class="form-control form-control input-block"
              autocomplete="current-password"
            />

            <button
              type="submit"
              name="commit"
              class="btn btn-primary btn-block"
            >
              Sign in
            </button>
          </form>
        </div>

        <p class="login-callout">
          <a href="./signup">Create an account</a>
        </p>
      </div>
    </main>
  </body>
</html>

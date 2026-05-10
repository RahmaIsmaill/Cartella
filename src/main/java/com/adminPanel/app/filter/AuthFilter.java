package com.adminPanel.app.filter;

import com.adminPanel.app.enums.Roles;
import com.adminPanel.app.model.user.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/products/*", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpServletResponse httpResponse =
                (HttpServletResponse) response;

        String path = httpRequest.getRequestURI();

        if (path.endsWith("/signin")
                || path.endsWith("/signup")
                || path.endsWith("/signout")) {

            chain.doFilter(request, response);
            return;
        }

        HttpSession session =
                httpRequest.getSession(false);

        User loggedUser =
                session != null
                        ? (User) session.getAttribute("loggedUser")
                        : null;

        if (loggedUser == null) {

            httpResponse.sendRedirect(
                    httpRequest.getContextPath()
                            + "/signin"
            );

            return;
        }

        if (path.contains("/admin/")
                && loggedUser.getRole() != Roles.ADMIN) {

            httpResponse.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access denied"
            );

            return;
        }

        chain.doFilter(request, response);
    }
}
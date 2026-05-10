package com.adminPanel.app.filter;

import com.adminPanel.app.enums.Roles;
import com.adminPanel.app.model.user.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        User user =
                (User) req.getSession().getAttribute("loggedUser");

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (user.getRole() != Roles.ADMIN) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Access Denied");
            return;
        }

        chain.doFilter(request, response);
    }
}
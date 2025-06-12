package controller;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = { "/*" })
public class AuthenticationFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();

		
		HttpSession session = req.getSession(false);
		boolean isLoggedIn = (session != null && session.getAttribute("usuarioLogado") != null);

		
		boolean isLoginPage = uri.equals(contextPath + "/login");
		boolean isLogoutPage = uri.equals(contextPath + "/logout");
		boolean isPublicResource = uri.startsWith(contextPath + "/css/") || uri.startsWith(contextPath + "/js/")
				|| uri.startsWith(contextPath + "/images/");

		if (isLoggedIn || isLoginPage || isLogoutPage || isPublicResource) {
			
			chain.doFilter(request, response);
		} else {
			
			res.sendRedirect(contextPath + "/login");
		}
	}
}
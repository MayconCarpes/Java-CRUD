package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ModelException;
import model.User;
import model.dao.DAOFactory;
import model.dao.UserDAO;

@WebServlet({ "/login", "/logout" })
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();

		
		if (uri.equals(contextPath + "/logout")) {
			HttpSession session = req.getSession(false);
			if (session != null) {
				session.invalidate();
				}
			ControllerUtil.redirect(resp, contextPath + "/login");
		} else {
			ControllerUtil.forward(req, resp, "/login.jsp");
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	    String contextPath = req.getContextPath();

	    String email = req.getParameter("email");
	    String password = req.getParameter("senha"); 

	    UserDAO userDAO = DAOFactory.createDAO(UserDAO.class);
	    User user = null;

	    try {
	        user = userDAO.findByUsernameAndPassword(email, password);
	    } catch (ModelException e) {
	        e.printStackTrace();
	        ControllerUtil.errorMessage(req, "Erro no servidor ao tentar login.");
	    }

	    if (user != null) {
	        HttpSession session = req.getSession();
	        session.setAttribute("usuarioLogado", user);
	        
	        ControllerUtil.redirect(resp, contextPath + "/");
	    } else {
	        req.setAttribute("error", "Email ou senha inválidos.");
	        ControllerUtil.forward(req, resp, "/login.jsp");
	    }
	}
}
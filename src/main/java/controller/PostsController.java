package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelException;
import model.Post;
import model.User;
import model.dao.DAOFactory;
import model.dao.PostDAO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/post", "/posts"})
public class PostsController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		
		if (req.getRequestURI().endsWith("/posts")) {
			action = "list";
		}

		if (action == null) {
			action = "list"; 
		}
		
		switch (action) {
		case "new":
			CommonsController.listUsers(req);
			req.setAttribute("action", "insert");
			ControllerUtil.forward(req, resp, "/form-post.jsp");
			break;
		case "edit":
			Post p = loadPost(req);
			CommonsController.listUsers(req);
			req.setAttribute("post", p);
			req.setAttribute("action", "update");
			ControllerUtil.forward(req, resp, "/form-post.jsp");
			break;
		case "list":
		default:
			listPosts(req);
			ControllerUtil.transferSessionMessagesToRequest(req);
			ControllerUtil.forward(req, resp, "/index.jsp");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		if (action == null) {
			ControllerUtil.redirect(resp, req.getContextPath() + "/posts");
			return;
		}
		
		switch (action) {
		case "delete":
			deletePost(req, resp);
			break;
		case "insert":
			insertPost(req, resp);
			break;
		case "update":
			updatePost(req, resp); // Agora esta chamada funciona
			break;
		default:
			System.out.println("Ação POST inválida: " + action);
		}
		ControllerUtil.redirect(resp, req.getContextPath() + "/posts");
	}
	
	private void deletePost(HttpServletRequest req, HttpServletResponse resp) {
	    try {
	        String postIdParameter = req.getParameter("id");
	        int postId = Integer.parseInt(postIdParameter);
	        
	        PostDAO dao = DAOFactory.createDAO(PostDAO.class);
	        Post postParaDeletar = new Post(postId);

	        // A checagem do boolean que o DAO retorna é crucial
	        if (dao.delete(postParaDeletar)) {
	            ControllerUtil.sucessMessage(req, "Post deletado com sucesso!");
	        } else {
	            ControllerUtil.errorMessage(req, "Post com ID " + postId + " não pôde ser deletado (não foi encontrado).");
	        }
	        
	    } catch (Exception e) {
	        ControllerUtil.errorMessage(req, "Erro ao deletar post: " + e.getMessage());
	        e.printStackTrace();
	    }
	}
	
	private void insertPost(HttpServletRequest req, HttpServletResponse resp) {
		try {
			Post post = new Post();
			post.setContent(req.getParameter("content"));
			post.setPostDate(Calendar.getInstance().getTime());
			post.setUser(new User(Integer.parseInt(req.getParameter("user"))));
			
			PostDAO dao = DAOFactory.createDAO(PostDAO.class);
			if (dao.save(post)) {
			    ControllerUtil.sucessMessage(req, "Post salvo com sucesso.");
            } else {
                ControllerUtil.errorMessage(req, "Erro ao salvar post.");
            }
		} catch (Exception e) {
			ControllerUtil.errorMessage(req, "Erro ao salvar post: " + e.getMessage());
			e.printStackTrace();
		}
	}

	// MÉTODO CORRIGIDO
	private void updatePost(HttpServletRequest req, HttpServletResponse resp) {
		try {
			Post post = loadPost(req);
			post.setContent(req.getParameter("content"));
			post.setUser(new User(Integer.parseInt(req.getParameter("user"))));
			
			PostDAO dao = DAOFactory.createDAO(PostDAO.class);
			if (dao.update(post)) {
			    ControllerUtil.sucessMessage(req, "Post atualizado com sucesso.");
            } else {
                ControllerUtil.errorMessage(req, "Erro ao atualizar post.");
            }
		} catch (Exception e) {
			ControllerUtil.errorMessage(req, "Erro ao atualizar post: " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	private void listPosts(HttpServletRequest req) {
		PostDAO dao = DAOFactory.createDAO(PostDAO.class);
		List<Post> posts = new ArrayList<>();
		try {
			posts = dao.listAll();
		} catch (ModelException e) {
			e.printStackTrace();
		}
		req.setAttribute("posts", posts);
	}

	private Post loadPost(HttpServletRequest req) {
		try {
			int postId = Integer.parseInt(req.getParameter("id"));
			PostDAO dao = DAOFactory.createDAO(PostDAO.class);
			return dao.findById(postId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
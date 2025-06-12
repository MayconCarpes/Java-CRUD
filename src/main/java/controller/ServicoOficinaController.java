package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelException;
import model.ServicoOficina;
import model.User;
import model.dao.DAOFactory;
import model.dao.ServicoOficinaDAO;

@WebServlet({"/servico", "/servicos"})
public class ServicoOficinaController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listServicos(req, resp);
                break;
            case "new":
                showForm(req, resp, "insert");
                break;
            case "edit":
                showForm(req, resp, "update");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
             ControllerUtil.redirect(resp, req.getContextPath() + "/servicos");
             return;
        }

        switch (action) {
            case "insert":
                insertServico(req);
                break;
            case "update":
                updateServico(req);
                break;
            case "delete":
                deleteServico(req);
                break;
        }
        
        ControllerUtil.redirect(resp, req.getContextPath() + "/servicos");
    }
    
    private void showForm(HttpServletRequest req, HttpServletResponse resp, String formAction) throws ServletException, IOException {
        if (formAction.equals("update")) {
            int id = Integer.parseInt(req.getParameter("id"));
            ServicoOficinaDAO dao = DAOFactory.createDAO(ServicoOficinaDAO.class);
            try {
                ServicoOficina servico = dao.findById(id);
                req.setAttribute("servico", servico);
            } catch (ModelException e) {
                e.printStackTrace();
            }
        }
        
        CommonsController.listUsers(req);
        req.setAttribute("action", formAction);
        ControllerUtil.forward(req, resp, "/form-servico.jsp");
    }

    private void listServicos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServicoOficinaDAO dao = DAOFactory.createDAO(ServicoOficinaDAO.class);
        try {
            List<ServicoOficina> servicos = dao.listAll();
            req.setAttribute("servicos", servicos);
        } catch (ModelException e) {
            e.printStackTrace();
        }
        ControllerUtil.transferSessionMessagesToRequest(req);
        ControllerUtil.forward(req, resp, "/lista-servicos.jsp");
    }

    private void insertServico(HttpServletRequest req) {
        ServicoOficina servico = createServicoFromRequest(req);
        ServicoOficinaDAO dao = DAOFactory.createDAO(ServicoOficinaDAO.class);
        try {
            if (dao.save(servico))
                ControllerUtil.sucessMessage(req, "Serviço salvo com sucesso!");
            else
                ControllerUtil.errorMessage(req, "Erro ao salvar serviço.");

        } catch (ModelException e) {
            e.printStackTrace();
        }
    }

    private void updateServico(HttpServletRequest req) {
        ServicoOficina servico = createServicoFromRequest(req);
        servico.setId(Integer.parseInt(req.getParameter("id")));
        ServicoOficinaDAO dao = DAOFactory.createDAO(ServicoOficinaDAO.class);
        try {
            if (dao.update(servico))
                ControllerUtil.sucessMessage(req, "Serviço atualizado com sucesso!");
            else
                ControllerUtil.errorMessage(req, "Erro ao atualizar serviço.");
        } catch (ModelException e) {
            e.printStackTrace();
        }
    }
    
    private void deleteServico(HttpServletRequest req) {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            ServicoOficinaDAO dao = DAOFactory.createDAO(ServicoOficinaDAO.class);
            ServicoOficina servico = new ServicoOficina(id);
            if (dao.delete(servico))
                ControllerUtil.sucessMessage(req, "Serviço deletado com sucesso!");
            else
                 ControllerUtil.errorMessage(req, "Erro ao deletar serviço.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private ServicoOficina createServicoFromRequest(HttpServletRequest req) {
        ServicoOficina servico = new ServicoOficina();
        try {
            servico.setDescricaoServico(req.getParameter("descricaoServico"));
            servico.setPlacaMoto(req.getParameter("placaMoto"));
            servico.setOrcamento(Double.parseDouble(req.getParameter("orcamento")));
            servico.setServicoConcluido(req.getParameter("servicoConcluido") != null);
            
            Date data = new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("dataEntrada"));
            servico.setDataEntrada(data);
            
            User cliente = new User(Integer.parseInt(req.getParameter("cliente_id")));
            servico.setCliente(cliente);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return servico;
    }
}
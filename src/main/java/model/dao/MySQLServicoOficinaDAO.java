package model.dao;

import java.util.ArrayList;
import java.util.List;
import model.ModelException;
import model.ServicoOficina;
import model.User;

public class MySQLServicoOficinaDAO implements ServicoOficinaDAO {

    @Override
    public boolean save(ServicoOficina servico) throws ModelException {
        DBHandler db = new DBHandler();

        String sqlInsert = "INSERT INTO servico_oficina VALUES (DEFAULT, ?, ?, ?, ?, ?, ?);";

        db.prepareStatement(sqlInsert);

        db.setString(1, servico.getDescricaoServico());
        db.setString(2, servico.getPlacaMoto());
        db.setDate(3, servico.getDataEntrada());
        db.setInt(4, (int) servico.getOrcamento());
        db.setInt(5, servico.isServicoConcluido() ? 1 : 0);
        db.setInt(6, servico.getCliente().getId());

        return db.executeUpdate() > 0;
    }

    @Override
    public boolean update(ServicoOficina servico) throws ModelException {
        DBHandler db = new DBHandler();

        String sqlUpdate = "UPDATE servico_oficina "
                         + "SET descricao_servico = ?, "
                         + "placa_moto = ?, "
                         + "data_entrada = ?, "
                         + "orcamento = ?, "
                         + "servico_concluido = ?, "
                         + "cliente_id = ? "
                         + "WHERE id = ?;";

        db.prepareStatement(sqlUpdate);

        db.setString(1, servico.getDescricaoServico());
        db.setString(2, servico.getPlacaMoto());
        db.setDate(3, servico.getDataEntrada());
        db.setInt(4, (int) servico.getOrcamento());
        db.setInt(5, servico.isServicoConcluido() ? 1 : 0);
        db.setInt(6, servico.getCliente().getId());
        db.setInt(7, servico.getId());

        return db.executeUpdate() > 0;
    }

    @Override
    public boolean delete(ServicoOficina servico) throws ModelException {
        DBHandler db = new DBHandler();
        String sqlDelete = "DELETE FROM servico_oficina WHERE id = ?;";

        db.prepareStatement(sqlDelete);
        db.setInt(1, servico.getId());

        return db.executeUpdate() > 0;
    }

    @Override
    public List<ServicoOficina> listAll() throws ModelException {
        DBHandler db = new DBHandler();
        List<ServicoOficina> servicos = new ArrayList<>();

        String sqlQuery = "SELECT s.*, u.nome as cliente_nome "
                        + "FROM servico_oficina s "
                        + "JOIN users u ON s.cliente_id = u.id;";

        db.createStatement();
        db.executeQuery(sqlQuery);

        while (db.next()) {
            ServicoOficina s = createServico(db);
            s.getCliente().setName(db.getString("cliente_nome"));
            servicos.add(s);
        }

        return servicos;
    }

    @Override
    public ServicoOficina findById(int id) throws ModelException {
        DBHandler db = new DBHandler();
        String sql = "SELECT * FROM servico_oficina WHERE id = ?;";

        db.prepareStatement(sql);
        db.setInt(1, id);
        db.executeQuery();

        ServicoOficina servico = null;
        if (db.next()) {
            servico = createServico(db);
        }

        return servico;
    }
    
    private ServicoOficina createServico(DBHandler db) throws ModelException {
        ServicoOficina s = new ServicoOficina(db.getInt("id"));
        s.setDescricaoServico(db.getString("descricao_servico"));
        s.setPlacaMoto(db.getString("placa_moto"));
        s.setDataEntrada(db.getDate("data_entrada"));
        s.setOrcamento(db.getInt("orcamento"));
        s.setServicoConcluido(db.getInt("servico_concluido") == 1);

        UserDAO userDAO = DAOFactory.createDAO(UserDAO.class);
        User cliente = userDAO.findById(db.getInt("cliente_id"));
        s.setCliente(cliente);

        return s;
    }
}
package model.dao;

import java.util.List;
import model.ModelException;
import model.ServicoOficina;

public interface ServicoOficinaDAO {
    boolean save(ServicoOficina servico) throws ModelException;
    boolean update(ServicoOficina servico) throws ModelException;
    boolean delete(ServicoOficina servico) throws ModelException;
    List<ServicoOficina> listAll() throws ModelException;
    ServicoOficina findById(int id) throws ModelException;
}
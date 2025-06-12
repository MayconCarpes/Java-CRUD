<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="servico" scope="request" class="model.ServicoOficina"/>
<!DOCTYPE html>
<html>
<head>
    <title>Formulário de Serviço</title>
    </head>
<body>
    <div class="container">
        <h3>${action == 'insert' ? 'Adicionar Novo' : 'Editar'} Serviço</h3>
        
        <form action="servico" method="post">
            <input type="hidden" name="action" value="${action}">
            <c:if test="${action == 'update'}">
                <input type="hidden" name="id" value="${servico.id}">
            </c:if>

            <div class="form-group">
                <label>Descrição do Serviço:</label>
                <textarea name="descricaoServico" class="form-control">${servico.descricaoServico}</textarea>
            </div>
            
            <div class="form-group">
                <label>Placa da Moto:</label>
                <input type="text" name="placaMoto" class="form-control" value="${servico.placaMoto}">
            </div>

            <div class="form-group">
                <label>Data de Entrada:</label>
                <input type="date" name="dataEntrada" class="form-control" value="${servico.dataEntrada}">
            </div>

            <div class="form-group">
                <label>Orçamento (R$):</label>
                <input type="number" name="orcamento" class="form-control" step="0.01" value="${servico.orcamento}">
            </div>

            <div class="form-group">
                <label>Cliente:</label>
                <select name="cliente_id" class="form-control">
                    <c:forEach var="user" items="${users}">
                        <option value="${user.id}" ${servico.cliente.id == user.id ? 'selected' : ''}>
                            ${user.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-check">
                <input type="checkbox" name="servicoConcluido" class="form-check-input" ${servico.servicoConcluido ? 'checked' : ''}>
                <label class="form-check-label">Serviço Concluído</label>
            </div>

            <hr>
            <button type="submit" class="btn btn-primary">Salvar</button>
            <a href="servico?action=list" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</body>
</html>
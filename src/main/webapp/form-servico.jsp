<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="servico" scope="request" class="model.ServicoOficina"/>
<!DOCTYPE html>
<html>
<head>
    <title>Formulário de Serviço</title>
    <%@include file="base-head.jsp"%>
</head>
<body>
    <%@include file="nav-menu.jsp"%>
    <div class="container">
        <h3>${action == 'insert' ? 'Adicionar Novo' : 'Editar'} Serviço</h3>
        <hr>
        <form action="servico" method="post">
            <input type="hidden" name="action" value="${action}">
            <c:if test="${action == 'update'}">
                <input type="hidden" name="id" value="${servico.id}">
            </c:if>

            <div class="row">
                <div class="form-group col-md-12">
                    <label>Descrição do Serviço:</label>
                    <textarea name="descricaoServico" class="form-control" required>${servico.descricaoServico}</textarea>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-4">
                    <label>Placa da Moto:</label>
                    <input type="text" name="placaMoto" class="form-control" value="${servico.placaMoto}" required>
                </div>
                <div class="form-group col-md-4">
                    <label>Data de Entrada:</label>
                    <fmt:formatDate value="${servico.dataEntrada}" pattern="yyyy-MM-dd" var="formattedDate"/>
                    <input type="date" name="dataEntrada" class="form-control" value="${formattedDate}" required>
                </div>
                 <div class="form-group col-md-4">
                    <label>Orçamento (R$):</label>
                    <input type="number" name="orcamento" class="form-control" step="0.01" value="${servico.orcamento}" required>
                </div>
            </div>
            <div class="row">
                 <div class="form-group col-md-4">
                    <label>Cliente:</label>
                    <select name="cliente_id" class="form-control" required>
                        <option value="">Selecione um cliente</option>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.id}" ${servico.cliente.id == user.id ? 'selected' : ''}>
                                <c:out value="${user.name}" />
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-md-8">
                    <label>&nbsp;</label>
                    <div class="form-check">
                        <input type="checkbox" name="servicoConcluido" class="form-check-input" ${servico.servicoConcluido ? 'checked' : ''}>
                        <label class="form-check-label">Serviço Concluído</label>
                    </div>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <button type="submit" class="btn btn-primary">Salvar</button>
                    <a href="servicos" class="btn btn-secondary">Cancelar</a>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
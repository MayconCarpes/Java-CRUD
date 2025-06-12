<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Serviços da Oficina</title>
    </head>
<body>
    <div class="container">
        <h3>Gerenciamento de Serviços da Oficina</h3>
        <a href="servico?action=new" class="btn btn-primary">Novo Serviço</a>
        <hr>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descrição</th>
                    <th>Placa</th>
                    <th>Data de Entrada</th>
                    <th>Orçamento</th>
                    <th>Cliente</th>
                    <th>Concluído</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="servico" items="${servicos}">
                    <tr>
                        <td>${servico.id}</td>
                        <td>${servico.descricaoServico}</td>
                        <td>${servico.placaMoto}</td>
                        <td><fmt:formatDate value="${servico.dataEntrada}" pattern="dd/MM/yyyy"/></td>
                        <td><fmt:formatNumber value="${servico.orcamento}" type="currency"/></td>
                        <td>${servico.cliente.name}</td>
                        <td>${servico.servicoConcluido ? 'Sim' : 'Não'}</td>
                        <td>
                            <a href="servico?action=edit&id=${servico.id}">Editar</a>
                            </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
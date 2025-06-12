<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@include file="base-head.jsp"%>
</head>
<body>
    <%@include file="modal.html"%>
    <%@include file="nav-menu.jsp"%>

    <div id="container" class="container-fluid">
        <div id="alert" style="${not empty message ? 'display: block;' : 'display: none;'}" class="alert alert-dismissable ${alertType eq 1 ? 'alert-success' : 'alert-danger'}">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            ${message}
        </div>

        <div id="top" class="row">
            <div class="col-md-3">
                <h3>Serviços da Oficina</h3>
            </div>
            <div class="col-md-6">
                <div class="input-group h2">
                    <input name="data[search]" class="form-control" id="search" type="text" placeholder="Pesquisar serviços">
                    <span class="input-group-btn">
                        <button class="btn btn-danger" type="submit">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                    </span>
                </div>
            </div>
            <div class="col-md-3">
                <a href="servico?action=new" class="btn btn-danger pull-right h2"><span class="glyphicon glyphicon-plus"></span>&nbsp;Adicionar Serviço</a>
            </div>
        </div>

        <hr />

        <div id="list" class="row">
            <div class="table-responsive col-md-12">
                <table class="table table-striped table-hover" cellspacing="0" cellpadding="0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Descrição</th>
                            <th>Placa</th>
                            <th>Data Entrada</th>
                            <th>Orçamento</th>
                            <th>Cliente</th>
                            <th>Concluído</th>
                            <th class="text-center" colspan="2">Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="servico" items="${servicos}">
                            <tr>
                                <td>${servico.id}</td>
                                <td><c:out value="${servico.descricaoServico}" /></td>
                                <td>${servico.placaMoto}</td>
                                <td><fmt:formatDate value="${servico.dataEntrada}" pattern="dd/MM/yyyy"/></td>
                                <td><fmt:formatNumber value="${servico.orcamento}" type="currency" currencySymbol="R$ "/></td>
                                <td><c:out value="${servico.cliente.name}" /></td>
                                <td>${servico.servicoConcluido ? 'Sim' : 'Não'}</td>
                                <td class="actions">
                                    <a class="btn btn-info btn-xs" href="servico?action=edit&id=${servico.id}">
                                        <span class="glyphicon glyphicon-edit"></span>
                                    </a>
                                </td>
                                <td class="actions">
                                    <a class="btn btn-danger btn-xs modal-remove" 
                                       data-toggle="modal" 
                                       data-target="#delete-modal" 
                                       data-servico-id="${servico.id}" 
                                       data-servico-info="o serviço da moto placa ${servico.placaMoto}">
                                       <span class="glyphicon glyphicon-trash"></span>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="bottom" class="row">
            <div class="col-md-12">
                <ul class="pagination">
                    <li class="disabled"><a>&lt; Anterior</a></li>
                    <li class="disabled"><a>1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li class="next"><a href="#" rel="next">Próximo &gt;</a></li>
                </ul>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            setTimeout(function() {
                $("#alert").slideUp(500);
            }, 3000);

            // Script para o modal de exclusão
            $(".modal-remove").click(function () {
                // Pega os dados do botão clicado
                var servicoId = $(this).data('servico-id');
                var servicoInfo = $(this).data('servico-info');
                
                // Pega o formulário do modal
                var form = $("#form");
                
                // Define a action do formulário para o servlet de serviço
                form.attr("action", "servico");
                
                // Define o ID do serviço no input hidden do formulário
                form.find("#id").val(servicoId);
                
                // Define o texto de confirmação no corpo do modal
                $(".modal-body #hiddenValue").text(servicoInfo);
            });
        });
    </script>
</body>
</html>
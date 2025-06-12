<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Painel de Controle</title>
    <%@include file="base-head.jsp"%>
    <style>
        /* Estilo para fazer o painel inteiro ser clicável */
        .panel-clickable {
            cursor: pointer;
        }
        .panel-clickable:hover {
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <%@include file="nav-menu.jsp"%>

    <div class="container">
        <div class="page-header">
            <h1>Painel de Controle</h1>
            <p class="lead">Selecione um módulo para gerenciar.</p>
        </div>
        <div class="row">

            <div class="col-sm-4">
                <a href="${pageContext.request.contextPath}/users" style="text-decoration: none; color: inherit;">
                    <div class="panel panel-primary panel-clickable">
                        <div class="panel-heading">
                            <h3 class="panel-title"><span class="glyphicon glyphicon-user"></span> Gerenciar Usuários</h3>
                        </div>
                        <div class="panel-body">
                            Clique aqui para adicionar, editar e visualizar os usuários do sistema.
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-sm-4">
                <a href="${pageContext.request.contextPath}/posts" style="text-decoration: none; color: inherit;">
                    <div class="panel panel-success panel-clickable">
                        <div class="panel-heading">
                            <h3 class="panel-title"><span class="glyphicon glyphicon-list-alt"></span> Gerenciar Posts</h3>
                        </div>
                        <div class="panel-body">
                           Clique aqui para visualizar, criar e gerenciar todos os posts.
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-sm-4">
                <a href="${pageContext.request.contextPath}/servicos" style="text-decoration: none; color: inherit;">
                    <div class="panel panel-danger panel-clickable">
                        <div class="panel-heading">
                            <h3 class="panel-title"><span class="glyphicon glyphicon-wrench"></span> Serviços da Oficina</h3>
                        </div>
                        <div class="panel-body">
                            Clique aqui para gerenciar os serviços, orçamentos e clientes da oficina.
                        </div>
                    </div>
                </a>
            </div>

        </div>
    </div>
</body>
</html>
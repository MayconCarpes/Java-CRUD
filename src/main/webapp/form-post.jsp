<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="post" scope="request" class="model.Post"/>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@include file="base-head.jsp"%>
    <title>Formulário de Post</title>
</head>
<body>
    <%@include file="nav-menu.jsp"%>
    
    <div class="container">
        <h3>${action == 'insert' ? 'Adicionar' : 'Editar'} Post</h3>
        <hr>
        
        <form action="post" method="post">
            
            <input type="hidden" name="action" value="${action}">
            <c:if test="${action == 'update'}">
                <input type="hidden" name="id" value="${post.id}">
            </c:if>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="content">Conteúdo</label>
                        <textarea id="content" name="content" class="form-control" rows="5" placeholder="Conteúdo do post" required>${post.content}</textarea>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="user">Usuário</label>
                        <select id="user" name="user" class="form-control" required>
                            <option value="">Selecione um usuário</option>
                            <c:forEach var="u" items="${users}">
                                <option value="${u.id}" ${post.user.id == u.id ? 'selected' : ''}>
                                    <c:out value="${u.name}" />
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <hr>
            
            <div class="row">
                <div class="col-md-12">
                    <div class="pull-right">
                        <a href="posts" class="btn btn-default">Cancelar</a>
                        <button type="submit" class="btn btn-primary">${action == 'insert' ? 'Criar Post' : 'Salvar Alterações'}</button>
                    </div>
                </div>
            </div>

        </form>
    </div>
    
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>
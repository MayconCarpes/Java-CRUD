<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			        <h3>Posts</h3>
			    </div>
			 
			    <div class="col-md-6">
			        <div class="input-group h2">
			            <input name="data[search]" class="form-control" id="search" type="text" placeholder="Pesquisar posts">
			            <span class="input-group-btn">
			                <button class="btn btn-danger" type="submit">
			                    <span class="glyphicon glyphicon-search"></span>
			                </button>
			            </span>
			        </div>
			    </div>
			 
			    <div class="col-md-3">
			        <a href="post?action=new" class="btn btn-danger pull-right h2"><span class="glyphicon glyphicon-plus" /></span>&nbsp;Adicionar Post</a>
			    </div>
	     	</div>
	 
	     	<hr />
	     	
	     	<div id="list" class="row">
	     		<div class="table-responsive col-md-12">
			        <table class="table table-striped table-hover" cellspacing="0" cellpadding="0">
			            <thead>
			                <tr>
			                    <th>Data</th>
			                    <th>Conteúdo</th>
			                    <th>Usuário</th>
			                    <th class="text-center" colspan="2">Ações</th>
			                 </tr>
			            </thead>
			            <tbody>
			            	<c:forEach var="post" items="${posts}">
								<tr>
				                    <td><fmt:formatDate value="${post.postDate}" pattern="dd/MM/yyyy"/></td>
				                    <td><c:out value="${post.content}"/></td>
				                    <td><c:out value="${post.user.name}"/></td>
				                    <td class="actions">
				                        <a class="btn btn-info btn-xs" href="post?action=edit&id=${post.id}">
				                           <span class="glyphicon glyphicon-edit"></span>
				                        </a>
				                    </td>
				                    <td class="actions">
				                        <a class="btn btn-danger btn-xs modal-remove" 
										   data-toggle="modal" 
				                           data-target="#delete-modal"  
										   data-id="${post.id}" 
				                           data-info="o post '${post.content}'">
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
			        </ul></div>
	     	</div>
		</div>
		
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function() {
			    setTimeout(function() {
			        $("#alert").slideUp(500);
			    }, 3000);
			    
			    $(".modal-remove").click(function () {
					var id = $(this).data('id');
		            var info = $(this).data('info');
					var form = $("#form");
					
					// Aponta o formulário do modal para o servlet correto
					form.attr("action", "post");
					
					// Coloca o ID do item a ser deletado no campo escondido do formulário
					form.find("#id").val(id);
					
					// Atualiza o texto de confirmação
					$(".modal-body #hiddenValue").text(info);
		        });
			});
		</script>
	</body>
</html>
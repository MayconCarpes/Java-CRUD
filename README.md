# CRUD Manager - Módulo de Oficina Mecânica

## Descrição do Projeto

Este é um projeto acadêmico desenvolvido para a disciplina de Tecnologias de Desenvolvimento para Internet II. A aplicação é um sistema web construído em Java EE que demonstra os conceitos de um CRUD (Create, Read, Update, Delete) completo, seguindo o padrão de arquitetura MVC (Model-View-Controller) com Servlets e JSP.

O projeto partiu de uma base chamada `crud-manager` e foi estendido para incluir um novo módulo de gerenciamento para uma **Oficina de Motos**, além de um sistema de autenticação de usuários completo.

## Requisitos da Atividade

> O trabalho foi desenvolvido para atender aos seguintes requisitos:
> * Adicionar um novo CRUD ao projeto base.
> * O CRUD deve ter no mínimo 5 campos de tipos diferentes.
> * Um dos campos deve ser uma chave estrangeira para uma entidade existente.
> * A relação da chave estrangeira deve ser feita via `<select>` na interface.
> * Além do CRUD, um mecanismo de Login e segurança deve ser implementado.

## Funcionalidades Implementadas

* **Autenticação de Usuários:** Sistema completo de Login e Logout com controle de sessão e filtro de segurança.
* **Painel de Controle (Home):** Uma página inicial que serve como um dashboard para navegar entre os módulos.
* **CRUD de Usuários:** Gerenciamento completo de usuários.
* **CRUD de Posts:** Gerenciamento completo de posts.
* **CRUD de Serviços da Oficina:** Módulo principal da atividade. Permite gerenciar os serviços realizados na oficina, associando cada serviço a um cliente (usuário).

## Tecnologias Utilizadas

* **Linguagem:** Java 21
* **Servidor de Aplicação:** Apache Tomcat 10.1
* **Tecnologias Java EE:**
  * Jakarta Servlets 6.0
  * Jakarta Server Pages (JSP) 3.1
  * Jakarta Standard Tag Library (JSTL) 3.0
* **Banco de Dados:** MySQL
* **Frontend:** HTML5, CSS3, Bootstrap, JavaScript (com jQuery)
* **Padrões de Projeto:**
  * Model-View-Controller (MVC)
  * Data Access Object (DAO) com DAO Factory
  * Front Controller (simplificado, em cada servlet)

## Estrutura do Projeto

O código-fonte está organizado nos seguintes pacotes principais:

* `controller`: Contém as classes de Servlet, que atuam como os controladores do MVC, recebendo as requisições HTTP e orquestrando as respostas.
* `model`: Contém as classes de entidade (POJOs), que representam as estruturas de dados da aplicação (Ex: `User`, `Post`, `ServicoOficina`).
* `model.dao`: Implementa o padrão DAO. Contém as interfaces de acesso a dados e suas implementações concretas para MySQL.
* `model.utils`: Classes utilitárias, como o `PasswordEncryptor`.
* `src/main/webapp` (ou `WebContent`): Contém as páginas de visão (JSPs), arquivos de estilo (CSS), scripts (JS) e imagens.

## Configuração do Ambiente

Siga os passos abaixo para executar o projeto localmente.

### 1. Banco de Dados

É necessário ter um servidor MySQL em execução.

#### 1.1. Crie o Banco de Dados

```sql
CREATE DATABASE crud_manager CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# **Sistema de cadastro de Livros**

1. Instalar a versão 2.7.1 do Ruby (dica: Usar rvm)

2. Instalar as dependências do projeto (bundle)

3. Criar o arquivo de configuração do banco de dados config/database.yml copiando o config/database.yml.example

4. Configurar suas credenciais locais do mysql no database.yml

5. Preparar o banco de dados (dica: usar rails db:reset, isso irá criar o banco e as tabelas, e também vai popular o banco de dados usando o arquivo seeds.rb)

6. Caso julgue interessante, pode rodar os testes utilizando o rspec (dica: para os testes de controllers, a aplicação precisa estar em execução)

7. Rodar a aplicação (rails s)

**Regras de negócio**

_Editora_
* Model : publishing_company.rb 
* Tem como único atributo o nome (name), sendo obrigatório.
* Tem uma relação 1 para N com livros (book.rb)

_Gênero_
* Model : genre.rb
* Tem como único atributo o nome (name), sendo obrigatório.
* Tem uma relação 1 para N com livros (book.rb)

_Autor_
* Model: author.rb
* Tem como único atributos:
  * Nome (name): obrigatório
  * Imagem (avatar): opcional
* Tem uma relação 1 para N com livros (book.rb)

_Livro_
* Model: book.rb
* Tem como atributos:
  * Título (title): obrigatório
  * Descrição (description): obrigatório
  * Id do autor (author_id): obrigatório
  * Id do gênero (genre_id): obrigatório
  * Id da editora (publishing_company_id): obrigatório
  * imagem (image): opcional

**Algumas informações sobre a aplicação**

1. _SGBD_: MySQL
2. _Armazenamento de Arquivos(avatar do autor e imagem do livro)_: São feitos localmente, salvos dentro da pasta public, essa foi a alternativa escolhida pelo motivo de não precisar criar uma conta AWS para usar uma alternativa mais viável como o s3, por exemplo.
3. _Rota Railz_: A rota raiz do projeto, localhost:3000 (rodando localmente) foi mapeada para exibir a listagem de todos os livros.
4. _Documentação_: A collection (**books-system-api.postman_collection.json**) e o environment (**books-system-api.postman_environment.json**) estão contidos no repositório. Importando-os no postman, é possível testar e realizar todo o fluxo de funcionamento da **API**.
5. _Endpoints_:
  * Privados (acessíveis apenas por administradores)
    * Login
    * Logout
    * Criação, edição e exclusão de editoras.
    * Criação, edição e exclusão de autores.
    * Criação, edição e exclusão de gêneros.
    * Criação, edição e exclusão de livros.

  * Públicos (accesíveis por qualquer pessoa)
    * Editora
      * Detalhes
      * Listagem
      * Listagem de livros de uma editora.
    * Gênero
      * Detalhes
      * Listagem
      * Listagem de livros de um gênero.
    * Autor
      * Detalhes
      * Listagem
      * Listagem de livros de um autor.
    * Livros
      * Detalhes
      * Listagem
    
  * Obs: Todos os endpoints de listagem permitem a utilização de filtros, todos eles estão exemplificados na collection.

  * O arquivo de seeds do projeto realiza o cadastro de um administrador, cujas credenciais estão descritas no endpoint de login, na collection.

  * O **filtro title_or_description** funciona em todos os endpoints de listagem de livros e busca todos os livros em que o título ou descrição correspondam ao texto digitado. Então a cada caractere digitado, o frontend que utilizá-lo conseguirá atualizar a página com o resultado da busca. Esse cenário pode ser simulado via postman, fazendo a requisição sempre que o texto for atualizado.
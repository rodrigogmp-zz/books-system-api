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
1. Model : publishing_company.rb 
2. Tem como único atributo o nome (name), sendo obrigatório.
3. Tem uma relação 1 para N com livros (book.rb)

_Gênero_
1. Model : genre.rb
2. Tem como único atributo o nome (name), sendo obrigatório.
3. Tem uma relação 1 para N com livros (book.rb)

_Autor_
1. Model: author.rb
2. Tem como único atributos:
  * Nome (name): obrigatório
  * Imagem (avatar): opcional
3. Tem uma relação 1 para N com livros (book.rb)

_Livro_
1. Model: book.rb
2. Tem como atributos:
  * Título (title): obrigatório
  * Descrição (description): obrigatório
  * Id do autor (author_id): obrigatório
  * Id do gênero (genre_id): obrigatório
  * Id da editora (publishing_company_id): obrigatório
  * imagem (image): opcional

**Algumas informações sobre a aplicação**

_SGBD_ : MySQL
_Armazenamento de Arquivos(avatar do autor e imagem do livro)_: São feitos localmente, salvos dentro da pasta public, essa foi alternativa escolhida pelo motivo de não precisar criar uma conta AWS para usar uma alternativa mais viável, como o s3, por exemplo.
_Rota Railz_: A rota raiz do projeto, localhost:3000 (rodando localmente) foi mapeada para exibir a listagem de todos os livros.
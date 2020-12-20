require 'rails_helper'

RSpec.describe Api::V1::Admin::BooksController, type: :controller do
  let(:genre) { Genre.create(name: 'Gênero Teste') }
  let(:author) { Author.create(name: 'Autor Teste') }
  let(:publishing_company) { PublishingCompany.create(name: 'Editora Teste') }
  let(:book) { Book.create(title: 'Título Teste', description: 'Descrição Teste', author_id: author.id, genre_id: genre.id, publishing_company_id: publishing_company.id) }
  let(:admin) { Admin.create(title: 'admin@admin.com', password: '123456')}

  describe 'Post #create not creating a book because missing permissions' do
    before do
      get :create, params: { title: 'titulo', description: 'descricao', author_id: author.id, publishing_company_id: publishing_company.id, genre_id: genre.id} , format: :json
    end
  
    it { expect(response).to have_http_status(401) }
  end

  describe 'Patch #update not updating a book because missing permissions' do
    before do
      get :create, params: { id: 1, title: 'titulo', description: 'descricao', author_id: author.id, publishing_company_id: publishing_company.id, genre_id: genre.id} , format: :json
    end
  
    it { expect(response).to have_http_status(401) }
  end


end
require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  let(:genre) { Genre.create(name: 'Gênero Teste') }
  let(:author) { Author.create(name: 'Autor Teste') }
  let(:publishing_company) { PublishingCompany.create(name: 'Editora Teste') }
  let(:book) { Book.create(title: 'Título Teste', description: 'Descrição Teste', author_id: author.id, genre_id: genre.id, publishing_company_id: publishing_company.id) }


  describe 'GET #index' do
    before do
      get :index, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show finding book' do
    before do
      get :show, params: { id: book.id } , format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show not founding book' do
    before do
      get :show, params: { id: 2 } , format: :json
    end

    it { expect(response).to have_http_status(404) }
  end
end
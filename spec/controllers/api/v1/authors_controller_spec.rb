require 'rails_helper'

RSpec.describe Api::V1::AuthorsController, type: :controller do
  let(:author) { Author.create(name: 'Autor Teste') }

  describe 'GET #index' do
    before do
      get :index, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show finding author' do
    before do
      get :show, params: { id: author.id } , format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show not founding user' do
    before do
      get :show, params: { id: 2 } , format: :json
    end

    it { expect(response).to have_http_status(404) }
  end
end
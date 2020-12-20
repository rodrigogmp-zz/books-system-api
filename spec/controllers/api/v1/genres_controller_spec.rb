require 'rails_helper'

RSpec.describe Api::V1::GenresController, type: :controller do
  let(:genre) { Genre.create(name: 'Gênero Teste') }

  describe 'GET #index' do
    before do
      get :index, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show finding user' do
    before do
      get :show, params: { id: genre.id } , format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show not founding genre' do
    before do
      get :show, params: { id: 2 } , format: :json
    end

    it { expect(response).to have_http_status(404) }
  end
end
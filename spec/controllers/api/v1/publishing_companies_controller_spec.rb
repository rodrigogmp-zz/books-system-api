require 'rails_helper'

RSpec.describe Api::V1::PublishingCompaniesController, type: :controller do
  let(:publishing_company) { PublishingCompany.create(name: 'Editora Teste') }

  describe 'GET #index' do
    before do
      get :index, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show finding user' do
    before do
      get :show, params: { id: publishing_company.id } , format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show nou founding publishing company' do
    before do
      get :show, params: { id: 2 } , format: :json
    end

    it { expect(response).to have_http_status(404) }
  end
end
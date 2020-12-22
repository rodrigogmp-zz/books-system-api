require 'rails_helper'

RSpec.describe Api::V1::Admin::GenresController, type: :controller do
  let(:genre) { Genre.create(name: 'Gênero Teste') }
  let(:admin) { Admin.create(title: 'admin@admin.com', password: '123456') }

  describe 'Post #create not creating a genre because missing permissions' do
    before do
      post :create, params: { genre: genre.name } , format: :json
    end
  
    it { expect(response).to have_http_status(401) }
  end

  describe 'Patch #update not updating a genre because missing permissions' do
    before do
      patch :update, params: { id: 1 } , format: :json
    end
  
    it { expect(response).to have_http_status(401) }
  end

  describe 'Delete #destroy not deleting a genre because missing permissions' do
    before do
      delete :destroy, params: { id: 1 }
    end
  
    it { expect(response).to have_http_status(401) }
  end

  it 'Post #create to creating a genre returns success' do
    login_response = HTTParty.post('http://localhost:3000/auth/sign_in', body: { email: 'admin@admin.com', password: "123456" })

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/genres', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })

    genre_id = JSON.parse(create_response.body)['id']
    
    HTTParty.delete("http://localhost:3000/api/v1/admin/genres/#{genre_id}",
        headers: {
            client: login_response.headers['client'],
            uid: login_response.headers['uid'], 
            access_token: login_response.headers['access-token']
        }
    )

    expect(create_response.code).to eq(200)
  end

  it 'Patch #update to update a genre returns success' do
    login_response = HTTParty.post('http://localhost:3000/auth/sign_in', body: { email: 'admin@admin.com', password: "123456" })
    
    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/genres', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })

    genre_id = JSON.parse(create_response.body)['id']
    
    update_response = HTTParty.patch("http://localhost:3000/api/v1/admin/genres/#{genre_id}", body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
      headers: {
        client: login_response.headers['client'],
        uid: login_response.headers['uid'], 
        access_token: login_response.headers['access-token']
      })

    HTTParty.delete("http://localhost:3000/api/v1/admin/genres/#{genre_id}",
        headers: {
            client: login_response.headers['client'],
            uid: login_response.headers['uid'], 
            access_token: login_response.headers['access-token']
        }
    )
      
    expect(update_response.code).to eq(200)
  end

  it 'Delete #destroy a genre and returns success with a 204 status response' do
    login_response = HTTParty.post('http://localhost:3000/auth/sign_in', body: { email: 'admin@admin.com', password: "123456" })
    
    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/genres', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })

    genre_id = JSON.parse(create_response.body)['id']
    
    delete_response = HTTParty.delete("http://localhost:3000/api/v1/admin/genres/#{genre_id}",
      headers: {
        client: login_response.headers['client'],
        uid: login_response.headers['uid'], 
        access_token: login_response.headers['access-token']
      }
    )
      
    expect(delete_response.code).to eq(204)
  end
end
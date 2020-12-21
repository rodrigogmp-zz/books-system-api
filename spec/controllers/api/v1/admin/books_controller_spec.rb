require 'rails_helper'

RSpec.describe Api::V1::Admin::BooksController, type: :controller do
  let(:genre) { Genre.create(name: 'Gênero Teste') }
  let(:author) { Author.create(name: 'Autor Teste') }
  let(:publishing_company) { PublishingCompany.create(name: 'Editora Teste') }
  let(:book) { Book.create(title: 'Título Teste', description: 'Descrição Teste', author_id: author.id, genre_id: genre.id, publishing_company_id: publishing_company.id) }
  let(:admin) { Admin.create(title: 'admin@admin.com', password: '123456') }

  describe 'Post #create not creating a book because missing permissions' do
    before do
      post :create, params: { title: 'titulo', description: 'descricao', author_id: author.id, publishing_company_id: publishing_company.id, genre_id: genre.id} , format: :json
    end
  
    it { expect(response).to have_http_status(401) }
  end

  describe 'Patch #update not updating a book because missing permissions' do
    before do
      patch :update, params: { id: 1, title: 'titulo', description: 'descricao', author_id: author.id, publishing_company_id: publishing_company.id, genre_id: genre.id} , format: :json
    end
  
    it { expect(response).to have_http_status(401) }
  end

  describe 'Delete #destroy not deleting a book because missing permissions' do
    before do
      delete :destroy, params: { id: 1 }
    end
  
    it { expect(response).to have_http_status(401) }
  end

  it 'Post #create to creating a book returns success' do
    login_response = HTTParty.post('http://localhost:3000/auth/sign_in', body: { email: 'admin@admin.com', password: "123456" })
    

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/publishing_companies', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })
    
    publishing_company_id = JSON.parse(create_response.body)['id']

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/authors', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })

    author_id = JSON.parse(create_response.body)['id']

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/genres', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })

    genre_id = JSON.parse(create_response.body)['id']
    
    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/books', body: { 
      title: (0...50).map { ('a'..'z').to_a[rand(26)] }.join, 
      description: 'descricao', 
      author_id: author_id, 
      publishing_company_id: publishing_company_id, 
      genre_id: genre_id,
    },
      headers: {
        client: login_response.headers['client'],
        uid: login_response.headers['uid'], 
        access_token: login_response.headers['access-token']
      })  
    
    book_id = JSON.parse(create_response.body)['id']
    
    HTTParty.delete("http://localhost:3000/api/v1/admin/books/#{book_id}",
      headers: {
        client: login_response.headers['client'],
        uid: login_response.headers['uid'], 
        access_token: login_response.headers['access-token']
      }
    )

    expect(create_response.code).to eq(200)
  end

  it 'Patch #update to update a book returns success' do
    login_response = HTTParty.post('http://localhost:3000/auth/sign_in', body: { email: 'admin@admin.com', password: "123456" })
    

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/publishing_companies', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })
    
    publishing_company_id = JSON.parse(create_response.body)['id']

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/authors', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })

    author_id = JSON.parse(create_response.body)['id']

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/genres', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })

    genre_id = JSON.parse(create_response.body)['id']
    
    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/books', body: { 
      title: (0...50).map { ('a'..'z').to_a[rand(26)] }.join, 
      description: 'descricao', 
      author_id: author_id, 
      publishing_company_id: publishing_company_id, 
      genre_id: genre_id,
    },
      headers: {
        client: login_response.headers['client'],
        uid: login_response.headers['uid'], 
        access_token: login_response.headers['access-token']
      })  
    
    book_id = JSON.parse(create_response.body)['id']
    
    update_response = HTTParty.patch("http://localhost:3000/api/v1/admin/books/#{book_id}", body: { 
      title: (0...50).map { ('a'..'z').to_a[rand(26)] }.join, 
      description: 'descricao teste', 
      author_id: author_id, 
      publishing_company_id: publishing_company_id, 
      genre_id: genre_id,
    },
      headers: {
        client: login_response.headers['client'],
        uid: login_response.headers['uid'], 
        access_token: login_response.headers['access-token']
      })

    HTTParty.delete("http://localhost:3000/api/v1/admin/books/#{book_id}",
      headers: {
        client: login_response.headers['client'],
        uid: login_response.headers['uid'], 
        access_token: login_response.headers['access-token']
      }
    )
      
    expect(update_response.code).to eq(200)
  end

  it 'Delete #destroy a book and returns success with a 204 status response' do
    login_response = HTTParty.post('http://localhost:3000/auth/sign_in', body: { email: 'admin@admin.com', password: "123456" })
    

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/publishing_companies', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })
    
    publishing_company_id = JSON.parse(create_response.body)['id']

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/authors', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })

    author_id = JSON.parse(create_response.body)['id']

    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/genres', body: { 
      name: (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    },
    headers: {
      client: login_response.headers['client'],
      uid: login_response.headers['uid'], 
      access_token: login_response.headers['access-token']
    })

    genre_id = JSON.parse(create_response.body)['id']
    
    create_response = HTTParty.post('http://localhost:3000/api/v1/admin/books', body: { 
      title: (0...50).map { ('a'..'z').to_a[rand(26)] }.join, 
      description: 'descricao', 
      author_id: author_id, 
      publishing_company_id: publishing_company_id, 
      genre_id: genre_id,
    },
      headers: {
        client: login_response.headers['client'],
        uid: login_response.headers['uid'], 
        access_token: login_response.headers['access-token']
      })  
    
    book_id = JSON.parse(create_response.body)['id']
    
    delete_response = HTTParty.delete("http://localhost:3000/api/v1/admin/books/#{book_id}",
      headers: {
        client: login_response.headers['client'],
        uid: login_response.headers['uid'], 
        access_token: login_response.headers['access-token']
      }
    )
      
    expect(delete_response.code).to eq(204)
  end
end
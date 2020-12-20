require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:genre) { Genre.create(name: 'Gênero Teste') }
  let(:author) { Author.create(name: 'Autor Teste') }
  let(:publishing_company) { PublishingCompany.create(name: 'Editora Teste') }
  subject { described_class.new(title: 'Título Teste', description: 'Descrição Teste', author_id: author.id, genre_id: genre.id, publishing_company_id: publishing_company.id) }
  
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid because dont have a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because dont have a description' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because does not belong to an author' do
    subject.author_id = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because does not belong to an publishing company' do
    subject.publishing_company_id = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because does not belong to an genre' do
    subject.genre_id = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because does not belong to an publishing company' do
    subject.publishing_company_id = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because exists another with the same name' do
    subject.save

    another = Book.new(title: 'Título Teste', description: 'Descrição Teste', author_id: author.id, genre_id: genre.id, publishing_company_id: publishing_company.id)
    expect(another).to_not be_valid
  end

  it 'finds a book record using the name filter' do
    subject.save
    Book.filter(by_title: 'Tít').count.should be == 1
  end

  it 'finds a book record using the author filter' do
    subject.save
    Book.filter(by_author: 'Autor').count.should be == 1
  end

  it 'finds a book record using the genre filter' do
    subject.save
    Book.filter(by_genre: 'Gen').count.should be == 1
  end

  it 'finds a book record using the publishing company filter' do
    subject.save
    Book.filter(by_publishing_company: 'Edit').count.should be == 1
  end

  it 'finds a book record using the alphabetic asc order filter' do
    subject.save

    another = Book.create(title: 'Antigo Livro', description: 'Descrição Teste', author_id: author.id, genre_id: genre.id, publishing_company_id: publishing_company.id)

    books = Book.filter(by_alphabetic_order: 'asc').first.title.should be == 'Antigo Livro'
  end

  it 'finds a book record using the alphabetic desc order filter' do
    subject.save

    another = Book.create(title: 'Antigo Livro', description: 'Descrição Teste', author_id: author.id, genre_id: genre.id, publishing_company_id: publishing_company.id)

    books = Book.filter(by_alphabetic_order: 'desc').first.title.should be == 'Título Teste'
  end
end

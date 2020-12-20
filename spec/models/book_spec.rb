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
end

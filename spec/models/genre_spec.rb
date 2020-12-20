require 'rails_helper'

RSpec.describe Genre, type: :model do
  subject { described_class.new(name: 'Gênero Teste') }
  
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid because dont have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because exists another with the same name' do
    subject.save

    another = Genre.new(name: 'Gênero Teste')
    expect(another).to_not be_valid
  end
end

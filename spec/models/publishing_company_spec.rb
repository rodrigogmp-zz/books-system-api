require 'rails_helper'

RSpec.describe PublishingCompany, type: :model do
  subject { described_class.new(name: 'Editora Teste') }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it 'is invalid because dont have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because exists another with the same name' do
    subject.save

    another = PublishingCompany.new(name: 'Editora Teste')
    expect(another).to_not be_valid
  end
end

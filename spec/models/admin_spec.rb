require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject { described_class.new(email: 'admin@admin.com', password: '123456') }
  
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid because dont have an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because dont have a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid because exists another with the same email' do
    subject.save

    another = Admin.new(email: 'admin@admin.com', password: '123456')
    expect(another).to_not be_valid
  end

  it 'is invalid because password is too short' do
    subject.password = "12345"

    expect(subject).to_not be_valid
  end

  it 'is invalid because email is wih invalid format' do
    subject.email = "admin.com"

    expect(subject).to_not be_valid
  end
end

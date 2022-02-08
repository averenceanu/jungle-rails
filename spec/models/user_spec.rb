require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is valid" do 
      user = User.new(
        first_name: 'Alexander',
        last_name: 'John',
        email: 'john@example.com',
        password: 'password', 
        password_confirmation: 'password'
      )
    expect(user).to be_valid
    end

    it "password does not match" do
      user=User.new(
        first_name: 'Alexander',
        last_name: 'John',
        email: 'john@example.com',
        password: 'password', 
        password_confirmation: 'notsame'
      )
    user.valid?
    expect(user.errors[:password_confirmation]).to be_present
    end

    it "password does not exist" do 
      user= User.new(
        first_name: 'Alexander',
        last_name: 'John',
        email: 'john@example.com',
        password: nil, 
        password_confirmation: nil
      )
      user.valid?
      expect(user.errors[:password]).to include ("can't be blank")
    end 

    it "email is missing" do
      user = User.new(email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
  
      user.email = 'test@test.com' # valid state
      user.valid?
      expect(user.errors[:email]).not_to include("can't be blank")
    end

    it "first name is missing" do
      user = User.new(first_name: nil)
      expect(user).to be_invalid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "last name is missing" do
      user = User.new(last_name: nil)
      expect(user).to be_invalid
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'email must be unique' do
      user = User.new
      user.first_name = 'first_name'
      user.last_name = 'last_name'
      user.email = 'test@test.com'
      user.password = 'password'
      user.password_confirmation = 'password'

      user.save
    
      newUser = User.new
      newUser.first_name = 'first_name'
      newUser.last_name = 'last_name'
      newUser.email = 'test@test.com'
      newUser.password = 'password'
      newUser.password_confirmation = 'password'
      newUser.save
    
      expect(newUser.errors[:email].first).to eq('has already been taken')
    end

    it 'password length less than 5 characters is invalid' do
      user = User.new
      user.first_name = 'alex'
      user.last_name = 'ver'
      user.email = 'test@test.com'
      user.password = '1234'
      user.password_confirmation = '1234'
      expect(user).to be_invalid
    end

    it 'password length must be at-least 5 characters' do
      user = User.new
      user.first_name = 'test'
      user.last_name = 'test'
      user.email = 'test@test.com'
      user.password = '12345'
      user.password_confirmation = '12345'
      expect(user).to be_valid
    end
  end

  describe ".authenticate_with_credentials" do
    it 'should pass with valid credentials' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('john@example.com', 'password')
      expect(user).not_to be(nil)
    end

    it 'should not pass with valid credentials' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'test',
        password_confirmation: 'test'
      )
      user.save

      user = User.authenticate_with_credentials('john@example.com', 'test')
      expect(user).to be(nil)
    end

    it 'should pass with spaces present in email' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'test',
        password_confirmation: 'test'
      )
      user.save

      user = User.authenticate_with_credentials('  john@example.com ', 'test')
      expect(user).not_to be(nil)
    end

    it 'should pass with caps present in email' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'test',
        password_confirmation: 'test'
      )
      user.save

      user = User.authenticate_with_credentials('JOHN@example.COM', 'test')
      expect(user).not_to be(nil)
    end

  end
end 

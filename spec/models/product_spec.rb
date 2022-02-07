require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid" do 
      @product = Product.new
      @category = Category.new
      @category.name = "Shoes"
      @product.name = "Jimmy Choo"
      @product.price_cents = 10002222
      @product.quantity = 12
      @product.category = @category
      expect(@product.valid?).to be true
    end

    it "name presence" do 
      @product = Product.new
      @product.name = nil
      @product.valid?
      expect(@product.errors[:name]).to include ("can't be blank")

      @product.name = 'Jimmy Choo' # valid state
      @product.valid? 
      expect(@product.errors[:name]).not_to  include("can't be blank")
    end

    it "price presence" do 
      @product = Product.new
      @product.price = nil
      @product.valid?
      expect(@product.errors[:price_cents]).to include ("is not a number")

      @product.price = 1223444 # valid state
      @product.valid? 
      expect(@product.errors[:price_cents]).not_to  include("can't be blank")
    end

    it "quantity" do 
      @product = Product.new
      @product.quantity = nil
      @product.valid?
      expect(@product.errors[:quantity]).to include ("can't be blank")

      @product.quantity = 4 # valid state
      @product.valid? 
      expect(@product.errors[:quantity]).not_to  include("can't be blank")
    end
    
    it "has a category_id" do 
      @product = Product.new
      @category = Category.new
      @category.name = "Shoes"
      @product.category = nil
      @product.valid?
      expect(@product.errors[:category]).to include ("can't be blank")

      @product.category = @category
      @product.valid?
      expect(@product.errors[:category]).not_to include ("can't be blank")
    end

  end
end

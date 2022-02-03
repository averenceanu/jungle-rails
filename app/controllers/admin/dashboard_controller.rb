class Admin::DashboardController < ApplicationController
  # http_basic_authenticate_with name: ENV["HTTP_BASIC_USER"],
  # password: ENV["HTTP_BASIC_PASSWORD"]  

  http_basic_authenticate_with name:"Jungle", password: "book"

  def show
    @product_count = Product.count 

    @category_list = Product.group(:category_id).count
  end
end

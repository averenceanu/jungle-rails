class UsersController < ApplicationController
  # rendering the signup form 
  def new 
  end 

  # receiving the form and creating a user with form's param
  def create 
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to :root
    else 
      redirect_to '/signup'
    end
  end 
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

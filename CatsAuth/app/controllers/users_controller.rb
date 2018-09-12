class UsersController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    # debugger
    if @user.save
      
      login!(@user)
      redirect_to cats_url
    else
      render :new
    end 
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :session_token, :password) #may need password_digest???
  end
  
end
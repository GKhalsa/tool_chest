class SessionsController < ApplicationController

  def new
  end

  def create
    #find a user based on the input identifier => in this case username
    #check if I found a user and if their password is correct
    #if user and password correct, I will set session and send them somewhere
    #if no user or password is incorrect, I will send them back to the login page
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:error] = "Invalid Login"
      render :new
    end
  end

  def validate
    redirect_to relogin_path
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end

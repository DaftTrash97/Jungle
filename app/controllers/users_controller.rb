class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'User successfully registered and logged in!'
    else
      render :new
    end
  end

  def login
    @user = User.new(email: params[:user]&.fetch(:email, nil))
  
    if request.post?
      user = User.find_by(email: @user.email)
  
      if user && user.authenticate(params[:user]&.fetch(:password, nil))
        session[:user_id] = user.id
        redirect_to root_path, notice: 'Logged in successfully!'
      else
        flash.now[:alert] = 'Invalid email or password'
        render :login
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully!'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
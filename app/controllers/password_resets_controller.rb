class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!
      Notifier.password_reset(user).deliver_now
      flash[:success] = 'Please check your email'
      redirect_to login_path
    else
      flash.now[:notice] = 'Email not found'
      render action: 'new'
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
    if @user
      render action: 'edit'
    else
      render file: "public/404.html", status: :not_found
    end
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user && @user.update_attributes(user_params)
      @user.update_attributes(password_reset_token: nil)
      session[:user_id] = @user.id
      flash[:success] = "Password updated"
      redirect_to todo_lists_path
    else
      flash[:notice] = "Password reset token not found."
      render action: 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
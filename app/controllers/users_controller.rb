class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit([:first_name, :last_name,
                    :email, :password, :password_confirmation])
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_post_path, notice: "Account created! Welcome #{@user.first_name}!"
    else
      render :new
    end
  end
end

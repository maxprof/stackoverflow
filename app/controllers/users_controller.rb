class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User profile was successufly updated"
      redirect_to user_path(@user)
    end
  end

  private
    def user_params
       params.require(:user).permit(:email, :avatar, :login, :country, :date_of_birth, :city, :address)
    end
end




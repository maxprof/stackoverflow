class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:avatar, :login, :country, :date_of_birth, :city, :address, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:avatar, :login, :country, :date_of_birth, :city, :address, :email, :password, :password_confirmation, :current_password)
  end
end

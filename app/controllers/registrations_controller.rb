class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:fname, :lname, :phone, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:fname, :lname, :phone, :email, :password, :password_confirmation, :encrypted_password)
  end

  
end
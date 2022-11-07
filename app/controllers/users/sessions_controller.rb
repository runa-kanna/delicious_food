class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'guestuserでログインしました。'
  end
  
end
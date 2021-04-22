module ControllerMacros
  def login_as_admin
    user = User.new(email: 'admin@example.com', password: 'secret')
    user.admin = true
    user.save!
    # session[:user_id] = user.id
  end
end

# module ControllerMacros
#   def login_as_admin
#     user = User.new(email: 'admin@example.com', password: 'secret')
#     user.admin = true
#     user.save!
#     # session[:user_id] = user.id
#   end
# end

module ControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      admin = FactoryBot.create(:admin)
      sign_in admin, scope: :user # sign_in resource, scope: :user
    end
  end

  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:random_user)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end

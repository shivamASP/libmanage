class AddAdmin < ActiveRecord::Migration[6.1]
  def change
    User.create! do |u|
        u.email     = 'admin@lib.com'
        u.password  = 'admin@1'
        u.admin = true
    end
  end
end

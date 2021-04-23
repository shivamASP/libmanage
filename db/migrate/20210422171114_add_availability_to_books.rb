class AddAvailabilityToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :availability, :integer, default: 5
  end
end

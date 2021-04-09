class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.string :title
      t.string :author
      t.integer :published_in
      t.integer :volume

      t.timestamps
    end
  end
end

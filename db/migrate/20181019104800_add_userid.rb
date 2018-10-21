class AddUserid < ActiveRecord::Migration[4.2]
  def change
    add_column :questions, :user_id, :integer, foreign_key: true
  end
end

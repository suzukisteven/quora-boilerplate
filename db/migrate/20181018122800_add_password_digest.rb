class AddPasswordDigest < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :password_digest, :string
    remove_column :users, :password, :string
  end
end

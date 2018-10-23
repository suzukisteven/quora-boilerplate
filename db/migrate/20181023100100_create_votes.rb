class CreateVotes < ActiveRecord::Migration[4.2]
  def change
    create_table :votes do |t|
      t.belongs_to :user
      t.belongs_to :answer
      t.boolean :upvote
      t.timestamps
    end
  end
end

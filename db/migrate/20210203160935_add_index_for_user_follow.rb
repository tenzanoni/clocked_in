class AddIndexForUserFollow < ActiveRecord::Migration[6.0]
  def change
    add_index :user_follows, [:user_id, :followed_user_id]
  end
end

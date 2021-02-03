class CreateUserFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :user_follows do |t|
      t.references :user, foreign_key: true, type: :bigint, index: true
      t.bigint :followed_user_id, foreign_key: true, index: true
      t.timestamps
    end
  end
end

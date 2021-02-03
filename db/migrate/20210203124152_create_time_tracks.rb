class CreateTimeTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :time_tracks do |t|
      t.references :user, foreign_key: true, type: :bigint, index: true
      t.integer :track_type
      t.timestamps
    end
  end
end

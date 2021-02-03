class ChangeTimeTrackColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :time_tracks, :track_type
    add_column :time_tracks, :sleep_at, :datetime
    add_column :time_tracks, :wakeup_at, :datetime
  end
end

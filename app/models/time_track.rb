class TimeTrack < ApplicationRecord
  belongs_to :user

  default_scope { order(created_at: :desc) }

  enum track_type: { wakeup: 1, go_sleep: 2 }


end

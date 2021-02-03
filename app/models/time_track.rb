class TimeTrack < ApplicationRecord
  EXPOSE_ATTRIBUTES = %i[wakeup_at sleep_at].freeze
  belongs_to :user

  scope :desc_ord, -> { order(created_at: :desc) }
  scope :not_wakeup, -> { where(wakeup_at: nil) }

  def self.render_json_opt
    {
      only: EXPOSE_ATTRIBUTES
    }
  end

  def wakeup_at
    self[:wakeup_at]&.strftime('%Y/%m/%d %H:%M')
  end

  def sleep_at
    self[:sleep_at]&.strftime('%Y/%m/%d %H:%M')
  end
end

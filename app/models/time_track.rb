class TimeTrack < ApplicationRecord
  EXPOSE_ATTRIBUTES = %i[wakeup_at sleep_at].freeze
  belongs_to :user

  scope :desc_ord, -> { order(created_at: :desc) }
  scope :not_wakeup, -> { where(wakeup_at: nil) }
  scope :last_week, -> { where(created_at: (Date.today - Date.today.wday - 6)..(Date.today - Date.today.wday)) }

  def self.render_json_opt
    {
      only: EXPOSE_ATTRIBUTES,
      methods: [:sleep_hours]
    }
  end

  def wakeup_at
    self[:wakeup_at]&.strftime('%Y/%m/%d %H:%M')
  end

  def sleep_at
    self[:sleep_at]&.strftime('%Y/%m/%d %H:%M')
  end

  def sleep_hours
    return if wakeup_at.blank?
    ((wakeup_at.to_time - sleep_at.to_time) / 1.hour).round(1)
  end
end

FactoryBot.define do
  factory :time_track, class: TimeTrack do
    wakeup_at { 7.days.ago + (2..10).to_a.sample.hours }
    sleep_at { (7.days.ago) }
    created_at { 7.days.ago } # Recorded in the previous week
  end
end

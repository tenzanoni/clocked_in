module TimeTrackUtils
  def sort_by_sleep_hour(time_tracks)
    time_tracks.sort_by { |timetrack| timetrack.dig('sleep_hours').to_i }
  end
end
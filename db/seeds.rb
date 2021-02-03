# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Creating Users...'

%w[User1 User2 User3].each do |uname|
  User.create(name: uname)
end

puts 'Creating Time tracks...'

User.all.each do |user|
  5.times.each do
    user.time_tracks.create(
      sleep_at: Time.now - 7.days + (1..5).to_a.sample.hours,
      wakeup_at: Time.now - 7.days + (7..13).to_a.sample.hours,
      created_at: Time.now - 7.days
    )
  end
end
class User < ApplicationRecord
  has_many :time_tracks
  has_many :user_follows
  has_many :following_users, through: :user_follows, source: :following
end

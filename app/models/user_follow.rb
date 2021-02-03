class UserFollow < ApplicationRecord
  EXPOSE_ATTRIBUTE = %i[followed_user_id].freeze
  belongs_to :follower, foreign_key: :followed_user_id, class_name: 'User'

  belongs_to :following, foreign_key: :user_id, class_name: 'User'

  validates :followed_user_id, uniqueness: { scope: :user_id }
end

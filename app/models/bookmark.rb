class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :rice_ball

  validates :user_id, uniqueness: { scope: :rice_ball_id }
end

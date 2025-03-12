class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  has_many :rice_balls, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def already_bookmarked?(rice_ball)
    self.bookmarks.exists?(rice_ball_id: rice_ball.id)
  end
end

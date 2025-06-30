class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :omniauthable

  validates :name, presence: true

  has_many :rice_balls, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_rice_balls, through: :bookmarks, source: :rice_ball

  def already_bookmarked?(rice_ball)
    bookmarks.pluck(:rice_ball_id).include?(rice_ball.id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.nickname || auth.info.name
      user.email = auth.info.email || "#{auth.uid}@twitter.local"
      user.password = Devise.friendly_token[0, 20]
    end
  end
end

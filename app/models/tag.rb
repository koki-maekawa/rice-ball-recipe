class Tag < ApplicationRecord
  has_many :rice_ball_tags, dependent: :destroy
  has_many :rice_balls, through: :rice_ball_tags

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "rice_ball", "user" ]
  end
end

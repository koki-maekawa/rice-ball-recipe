class RiceBall < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  validates :title, presence: true
end

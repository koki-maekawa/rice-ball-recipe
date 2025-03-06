class RiceBall < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :ingredients, dependent: :destroy
end

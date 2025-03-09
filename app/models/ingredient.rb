class Ingredient < ApplicationRecord
  belongs_to :rice_ball

  validates :name, :amount, presence: true
end

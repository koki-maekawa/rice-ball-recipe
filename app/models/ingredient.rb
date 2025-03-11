class Ingredient < ApplicationRecord
  belongs_to :rice_ball

  validates :name, :amount, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "rice_ball", "user" ]
  end
end

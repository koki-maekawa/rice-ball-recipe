class Step < ApplicationRecord
  belongs_to :rice_ball

  validates :description, :step_number, presence: true
end

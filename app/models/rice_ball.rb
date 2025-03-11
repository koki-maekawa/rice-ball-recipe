class RiceBall < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :index, resize_and_pad: [ 500, 500 ], preprocessed: true
    attachable.variant :show, resize_and_pad: [ 1000, 1000 ], preprocessed: true
  end
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "created_at", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "ingredients", "user" ]
  end
end

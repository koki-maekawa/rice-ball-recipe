class RiceBall < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :index, resize_and_pad: [ 500, 500 ], preprocessed: true
    attachable.variant :show, resize_and_pad: [ 1000, 1000 ], preprocessed: true
  end
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true

  validate :correct_image_type
  validate :correct_image_size

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "created_at", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "ingredients", "user" ]
  end

  private

  def correct_image_type
    return unless image.attached?

    acceptable_types = [ "image/jpeg", "image/png" ]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, :image_type_invalid)
    end
  end

  def correct_image_size
    return unless image.attached?

    if image.byte_size > 5.megabytes
      errors.add(:image, :image_size_invalid)
    end
  end
end

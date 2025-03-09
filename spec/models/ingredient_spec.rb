require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'バリデーション' do
    it '材料/調味料名・量があれば有効であること' do
      ingredient = build(:ingredient)
      expect(ingredient).to be_valid
    end

    it '材料/調味料名がなければ無効であること' do
      ingredient = build(:ingredient, name: nil)
      expect(ingredient).to be_invalid
    end

    it '量がなければ無効であること' do
      ingredient = build(:ingredient, amount: nil)
      expect(ingredient).to be_invalid
    end
  end
end

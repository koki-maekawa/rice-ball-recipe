require 'rails_helper'

RSpec.describe Step, type: :model do
  describe 'バリデーション' do
    it '作り方・順番があれば有効であること' do
      step = build(:step)
      expect(step).to be_valid
    end

    it '作り方がなければ無効であること' do
      step = build(:step, description: nil)
      expect(step).to be_invalid
    end

    it '順番がなければ無効であること' do
      step = build(:step, step_number: nil)
      expect(step).to be_invalid
    end
  end
end

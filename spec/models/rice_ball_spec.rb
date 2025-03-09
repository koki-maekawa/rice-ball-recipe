require 'rails_helper'

RSpec.describe RiceBall, type: :model do
  describe 'バリデーション' do
    it 'タイトル・画像があれば有効であること' do
      rice_ball = build(:rice_ball)
      expect(rice_ball).to be_valid
    end

    it 'タイトルがなければ無効であること' do
      rice_ball = build(:rice_ball, title: nil)
      expect(rice_ball).to be_invalid
    end
  end
end

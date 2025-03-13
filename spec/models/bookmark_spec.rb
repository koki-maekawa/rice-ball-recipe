require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:rice_ball) { FactoryBot.create(:rice_ball) }

  context 'バリデーション' do
    it 'user_idとrice_ball_idの組み合わせが一意であること' do
      FactoryBot.create(:bookmark, user: user, rice_ball: rice_ball)

      duplicate_bookmark = Bookmark.new(user: user, rice_ball: rice_ball)
      expect(duplicate_bookmark).to be_invalid
    end
  end
end

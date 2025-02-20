require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '名前・メールアドレス・パスワードがあれば有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it '名前がなければ無効であること' do
      user = build(:user, name: nil)
      expect(user).to be_invalid
    end

    it 'メールアドレスがなければ無効であること' do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end

    it 'パスワードが6文字未満だと無効であること' do
      user = build(:user, password: '12345', password_confirmation: '12345')
      expect(user).to be_invalid
    end

    it '重複したメールアドレスは無効であること' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).to be_invalid
    end
  end
end

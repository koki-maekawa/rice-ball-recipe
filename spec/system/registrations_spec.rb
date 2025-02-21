require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  describe '新規登録ページ' do
    it '正常に新規登録ができること' do
      visit new_user_registration_path
      fill_in I18n.t('activerecord.attributes.user.name'), with: 'テストユーザー'
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'test@example.com'
      fill_in I18n.t('activerecord.attributes.user.password'), with: 'password'
      fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'password'
      click_button I18n.t('devise.registrations.new.sign_up')
      expect(page).to have_content I18n.t('devise.registrations.signed_up')
    end

    it '入力情報に不備があるとエラーメッセージが表示されること' do
      visit new_user_registration_path
      fill_in I18n.t('activerecord.attributes.user.name'), with: ''
      fill_in I18n.t('activerecord.attributes.user.email'), with: ''
      fill_in I18n.t('activerecord.attributes.user.password'), with: ''
      fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: ''
      click_button I18n.t('devise.registrations.new.sign_up')
      expect(page).to have_content I18n.t('errors.messages.blank')
    end
  end
end

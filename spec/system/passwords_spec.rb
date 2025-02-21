require 'rails_helper'

RSpec.describe 'passwords', :js, type: :system do
  let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }

  describe 'passwords#new' do
    it 'パスワードリセットの指示を送信できること' do
      visit new_user_password_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'test@example.com'
      click_button I18n.t('devise.passwords.new.send_me_reset_password_instructions')
      expect(page).to have_content I18n.t('devise.passwords.send_instructions')
    end

    it 'メールアドレスが空の場合エラーメッセージが表示されること' do
      visit new_user_password_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: ''
      click_button I18n.t('devise.passwords.new.send_me_reset_password_instructions')
      expect(page).to have_content I18n.t('errors.messages.blank')
    end
  end

  describe 'passwords#edit' do
    it '正常にパスワードを変更できること' do
      token = user.send_reset_password_instructions
      visit edit_user_password_path(reset_password_token: token)
      fill_in I18n.t('devise.passwords.edit.new_password'), with: 'newpassword'
      fill_in I18n.t('devise.passwords.edit.confirm_new_password'), with: 'newpassword'
      click_button I18n.t('devise.passwords.edit.change_my_password')
      expect(page).to have_content I18n.t('devise.passwords.updated')
    end

    it '入力情報に不備があるとエラーメッセージが表示されること' do
      token = user.send_reset_password_instructions
      visit edit_user_password_path(reset_password_token: token)
      fill_in I18n.t('devise.passwords.edit.new_password'), with: ''
      fill_in I18n.t('devise.passwords.edit.confirm_new_password'), with: ''
      click_button I18n.t('devise.passwords.edit.change_my_password')
      expect(page).to have_content I18n.t('errors.messages.blank')
    end
  end
end

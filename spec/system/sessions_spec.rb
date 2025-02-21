require 'rails_helper'

RSpec.describe 'ユーザーログイン', :js, type: :system do
  describe 'ログインページ' do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }

    it '正常にログインができること' do
      visit new_user_session_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'test@example.com'
      fill_in I18n.t('activerecord.attributes.user.password'), with: 'password'
      uncheck I18n.t('activerecord.attributes.user.remember_me')
      click_button I18n.t('devise.sessions.new.sign_in')
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
    end

    it '正常にログインができ、ログインを記憶するにチェックを入れる場合' do
      visit new_user_session_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'test@example.com'
      fill_in I18n.t('activerecord.attributes.user.password'), with: 'password'
      check I18n.t('activerecord.attributes.user.remember_me')
      click_button I18n.t('devise.sessions.new.sign_in')
      sleep 1
      expect(page.driver.browser.manage.cookie_named('remember_user_token')).not_to be_nil
    end

    it 'メールアドレスが存在しない場合にエラーメッセージが表示されること' do
      visit new_user_session_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'wrong@example.com'
      fill_in I18n.t('activerecord.attributes.user.password'), with: 'password'
      click_button I18n.t('devise.sessions.new.sign_in')
      expect(page).to have_content I18n.t('devise.failure.not_found_in_database', authentication_keys: I18n.t('activerecord.attributes.user.email'))
    end

    it 'パスワードが間違っている場合にエラーメッセージが表示されること' do
      visit new_user_session_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'test@example.com'
      fill_in I18n.t('activerecord.attributes.user.password'), with: 'wrongpassword'
      click_button I18n.t('devise.sessions.new.sign_in')
      expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: I18n.t('activerecord.attributes.user.email'))
    end
  end
end

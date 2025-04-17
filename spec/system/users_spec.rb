require 'rails_helper'

RSpec.describe 'ユーザー関連機能', :js, type: :system do
  describe 'ユーザー登録' do
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

  describe 'ログイン機能' do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }

    it '正常にログインができること' do
      visit new_user_session_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'test@example.com'
      fill_in I18n.t('activerecord.attributes.user.password'), with: 'password'
      uncheck I18n.t('activerecord.attributes.user.remember_me')
      click_button I18n.t('devise.sessions.new.sign_in')
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
    end

    it 'ログイン記憶をオンにしてログインできること' do
      visit new_user_session_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'test@example.com'
      fill_in I18n.t('activerecord.attributes.user.password'), with: 'password'
      check I18n.t('activerecord.attributes.user.remember_me')
      click_button I18n.t('devise.sessions.new.sign_in')
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
      cookie_names = []
      page.driver.with_playwright_page do |playwright_page|
        cookies = playwright_page.context.cookies
        cookie_names = cookies.map { |cookie| cookie['name'] }
      end
      expect(cookie_names).to include('remember_user_token')
    end

    it 'メールアドレスが存在しない場合エラーメッセージが表示されること' do
      visit new_user_session_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'wrong@example.com'
      fill_in I18n.t('activerecord.attributes.user.password'), with: 'password'
      click_button I18n.t('devise.sessions.new.sign_in')
      expect(page).to have_content I18n.t('devise.failure.not_found_in_database', authentication_keys: I18n.t('activerecord.attributes.user.email'))
    end

    it 'パスワードが間違っている場合エラーメッセージが表示されること' do
      visit new_user_session_path
      fill_in I18n.t('activerecord.attributes.user.email'), with: 'test@example.com'
      fill_in I18n.t('activerecord.attributes.user.password'), with: 'wrongpassword'
      click_button I18n.t('devise.sessions.new.sign_in')
      expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: I18n.t('activerecord.attributes.user.email'))
    end
  end

  describe 'パスワードリセット機能' do
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
end

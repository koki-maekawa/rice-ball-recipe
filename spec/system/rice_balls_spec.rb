require 'rails_helper'

RSpec.describe 'RiceBalls', :js, type: :system do
  let(:user) { create(:user) }
  let(:rice_ball) { create(:rice_ball, user: user) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'おにぎりレシピの新規登録ページにアクセス' do
        it '新規登録ページへのアクセスが失敗する' do
          visit new_rice_ball_path
          expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
          expect(current_path).to eq new_user_session_path
        end
      end

      context 'おにぎりレシピの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          visit edit_rice_ball_path(rice_ball)
          expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
          expect(current_path).to eq new_user_session_path
        end
      end

      context 'おにぎりレシピの詳細ページにアクセス' do
        it 'おにぎりレシピの詳細情報が表示される' do
          visit rice_ball_path(rice_ball)
          expect(page).to have_content rice_ball.title
          expect(current_path).to eq rice_ball_path(rice_ball)
        end
      end

      context 'おにぎりレシピの一覧ページにアクセス' do
        it 'すべてのユーザーのおにぎりレシピ情報が表示される' do
          rice_ball_list = create_list(:rice_ball, 3)
          visit rice_balls_path
          expect(page).to have_content rice_ball_list[0].title
          expect(page).to have_content rice_ball_list[1].title
          expect(page).to have_content rice_ball_list[2].title
          expect(current_path).to eq rice_balls_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { sign_in(user) }

    describe 'おにぎりレシピ新規登録' do
        context 'フォームの入力値が正常' do
            it 'おにぎりレシピの新規作成が成功する' do
                visit new_rice_ball_path
                fill_in I18n.t('activerecord.attributes.rice_ball.title'), with: 'テストおにぎり'
                attach_file I18n.t('activerecord.attributes.rice_ball.image'), Rails.root.join('spec/factories/test_image/onigiri.png')

                click_link I18n.t('defaults.add_ingredient_form')
                ingredients = [
                    { name: 'ごはん', amount: '150g' },
                    { name: '塩', amount: '少々' }
                ]
                all('[data-ingredient-forms-target="ingredientFields"]').each_with_index do |ingredient, index|
                    within ingredient do
                        fill_in I18n.t("defaults.ingredient_name_placeholder"), with: ingredients[index][:name]
                        fill_in I18n.t("defaults.ingredient_amount_placeholder"), with: ingredients[index][:amount]
                    end
                end

                click_link I18n.t('defaults.add_step_form')
                click_link I18n.t('defaults.add_step_form')
                steps = [
                    'ごはんを握る',
                    '塩をかける'
                ]
                all('[data-step-forms-target="stepFields"]').each_with_index do |step, index|
                    within step do
                        fill_in I18n.t("defaults.step_description_placeholder"), with: steps[index]
                    end
                end

                click_button I18n.t('defaults.recipe_submit')

                expect(page).to have_content 'テストおにぎり'
                expect(page).to have_css("img[src*='onigiri.png']")
                expect(page).to have_content I18n.t('rice_balls.create.success')

                find('.absolute.top-0.left-0.right-0.bottom-0').click
                expect(page).to have_content 'テストおにぎり'
                expect(page).to have_css("img[src*='onigiri.png']")
                expect(page).to have_content 'ごはん'
                expect(page).to have_content '150g'
                expect(page).to have_content '塩'
                expect(page).to have_content '少々'
                expect(page).to have_content 'ごはんを握る'
                expect(page).to have_content '塩をかける'
            end
        end

        context 'おにぎりタイトルが未入力' do
            it 'おにぎりレシピの新規作成が失敗する' do
                visit new_rice_ball_path
                fill_in I18n.t('activerecord.attributes.rice_ball.title'), with: ''
                attach_file I18n.t('activerecord.attributes.rice_ball.image'), Rails.root.join('spec/factories/test_image/onigiri.png')

                click_link I18n.t('defaults.add_ingredient_form')
                ingredients = [
                    { name: 'ごはん', amount: '150g' },
                    { name: '塩', amount: '少々' }
                ]
                all('[data-ingredient-forms-target="ingredientFields"]').each_with_index do |ingredient, index|
                    within ingredient do
                        fill_in I18n.t("defaults.ingredient_name_placeholder"), with: ingredients[index][:name]
                        fill_in I18n.t("defaults.ingredient_amount_placeholder"), with: ingredients[index][:amount]
                    end
                end

                click_link I18n.t('defaults.add_step_form')
                click_link I18n.t('defaults.add_step_form')
                steps = [
                    'ごはんを握る',
                    '塩をかける'
                ]
                all('[data-step-forms-target="stepFields"]').each_with_index do |step, index|
                    within step do
                       fill_in I18n.t("defaults.step_description_placeholder"), with: steps[index]
                    end
                end

                click_button I18n.t('defaults.recipe_submit')

                expect(page).to have_content "#{I18n.t('activerecord.attributes.rice_ball.title')}を入力してください"
                expect(current_path).to eq new_rice_ball_path
            end
        end

        context '材料・調味料名が未入力' do
            it 'おにぎりレシピの新規作成が失敗する' do
                visit new_rice_ball_path
                fill_in I18n.t('activerecord.attributes.rice_ball.title'), with: ''
                attach_file I18n.t('activerecord.attributes.rice_ball.image'), Rails.root.join('spec/factories/test_image/onigiri.png')

                click_link I18n.t('defaults.add_ingredient_form')
                ingredients = [
                    { name: '', amount: '150g' },
                    { name: '塩', amount: '少々' }
                ]
                all('[data-ingredient-forms-target="ingredientFields"]').each_with_index do |ingredient, index|
                    within ingredient do
                       fill_in I18n.t("defaults.ingredient_name_placeholder"), with: ingredients[index][:name]
                        fill_in I18n.t("defaults.ingredient_amount_placeholder"), with: ingredients[index][:amount]
                    end
                end
                click_link I18n.t('defaults.add_step_form')
                click_link I18n.t('defaults.add_step_form')
                steps = [
                    'ごはんを握る',
                    '塩をかける'
                ]
                all('[data-step-forms-target="stepFields"]').each_with_index do |step, index|
                    within step do
                       fill_in I18n.t("defaults.step_description_placeholder"), with: steps[index]
                    end
                end

                click_button I18n.t('defaults.recipe_submit')

                expect(page).to have_content "#{I18n.t('activerecord.attributes.ingredient.name')}を入力してください"
                expect(current_path).to eq new_rice_ball_path
            end
        end

        context '材料・調味料の量が未入力' do
            it 'おにぎりレシピの新規作成が失敗する' do
                visit new_rice_ball_path
                fill_in I18n.t('activerecord.attributes.rice_ball.title'), with: ''
                attach_file I18n.t('activerecord.attributes.rice_ball.image'), Rails.root.join('spec/factories/test_image/onigiri.png')

                click_link I18n.t('defaults.add_ingredient_form')
                ingredients = [
                    { name: 'ごはん', amount: '' },
                    { name: '塩', amount: '少々' }
                ]
                all('[data-ingredient-forms-target="ingredientFields"]').each_with_index do |ingredient, index|
                    within ingredient do
                       fill_in I18n.t("defaults.ingredient_name_placeholder"), with: ingredients[index][:name]
                        fill_in I18n.t("defaults.ingredient_amount_placeholder"), with: ingredients[index][:amount]
                    end
                end

                click_link I18n.t('defaults.add_step_form')
                click_link I18n.t('defaults.add_step_form')
                steps = [
                    'ごはんを握る',
                    '塩をかける'
                ]
                all('[data-step-forms-target="stepFields"]').each_with_index do |step, index|
                    within step do
                       fill_in I18n.t("defaults.step_description_placeholder"), with: steps[index]
                    end
                end

                click_button I18n.t('defaults.recipe_submit')

                expect(page).to have_content "#{I18n.t('activerecord.attributes.ingredient.amount')}を入力してください"
                expect(current_path).to eq new_rice_ball_path
            end
        end

        context '作り方が未入力' do
            it 'おにぎりレシピの新規作成が失敗する' do
                visit new_rice_ball_path
                fill_in I18n.t('activerecord.attributes.rice_ball.title'), with: ''
                attach_file I18n.t('activerecord.attributes.rice_ball.image'), Rails.root.join('spec/factories/test_image/onigiri.png')

                click_link I18n.t('defaults.add_ingredient_form')
                ingredients = [
                    { name: 'ごはん', amount: '150g' },
                    { name: '塩', amount: '少々' }
                ]
                all('[data-ingredient-forms-target="ingredientFields"]').each_with_index do |ingredient, index|
                    within ingredient do
                       fill_in I18n.t("defaults.ingredient_name_placeholder"), with: ingredients[index][:name]
                        fill_in I18n.t("defaults.ingredient_amount_placeholder"), with: ingredients[index][:amount]
                    end
                end

                click_link I18n.t('defaults.add_step_form')
                click_link I18n.t('defaults.add_step_form')
                steps = [
                    '',
                    '塩をかける'
                ]
                all('[data-step-forms-target="stepFields"]').each_with_index do |step, index|
                    within step do
                       fill_in I18n.t("defaults.step_description_placeholder"), with: steps[index]
                    end
                end

                click_button I18n.t('defaults.recipe_submit')

                expect(page).to have_content "#{I18n.t('activerecord.attributes.step.description')}を入力してください"
                expect(current_path).to eq new_rice_ball_path
            end
        end
    end

    describe 'おにぎりレシピ編集' do
        let(:rice_ball) { create(:rice_ball, :with_ingredients_and_steps, user: user) }

        context 'フォームの入力値が正常' do
            it 'おにぎりレシピの編集が成功する' do
                visit rice_ball_path(rice_ball)
                click_link I18n.t('rice_balls.show.edit')
                fill_in I18n.t('activerecord.attributes.rice_ball.title'), with: '編集後タイトル'
                attach_file I18n.t('activerecord.attributes.rice_ball.image'), Rails.root.join('spec/factories/test_image/food_konbini_onigiri.png')

                ingredients = [
                    { name: '編集後具材', amount: '150g' },
                    { name: '塩', amount: '少々' }
                ]
                all('[data-ingredient-forms-target="ingredientFields"]').each_with_index do |ingredient, index|
                    within ingredient do
                        fill_in I18n.t("defaults.ingredient_name_placeholder"), with: ingredients[index][:name]
                        fill_in I18n.t("defaults.ingredient_amount_placeholder"), with: ingredients[index][:amount]
                    end
                end

                steps = [
                    '編集後調理',
                    '塩をかける'
                ]
                all('[data-step-forms-target="stepFields"]').each_with_index do |step, index|
                    within step do
                        fill_in I18n.t("defaults.step_description_placeholder"), with: steps[index]
                    end
                end

                click_button I18n.t('defaults.recipe_submit')

                expect(page).to have_content I18n.t('rice_balls.update.success')
                expect(page).to have_content '編集後タイトル'
                expect(page).to have_css("img[src*='food_konbini_onigiri.png']")
                expect(page).to have_content '編集後具材'
                expect(page).to have_content '150g'
                expect(page).to have_content '塩'
                expect(page).to have_content '少々'
                expect(page).to have_content '編集後調理'
                expect(page).to have_content '塩をかける'
            end
        end
    end

    describe 'おにぎりレシピ削除' do
        it 'おにぎりレシピの削除が成功する' do
            visit rice_ball_path(rice_ball)
            message = page.accept_confirm do
                click_link I18n.t('rice_balls.show.destroy')
              end
            expect(message).to eq I18n.t('rice_balls.show.destroy_confirm')
            expect(page).to have_content I18n.t('rice_balls.destroy.success')
            expect(current_path).to eq rice_balls_path
            expect(page).not_to have_content rice_ball.title
        end
    end
  end
end

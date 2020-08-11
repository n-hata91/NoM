require 'rails_helper'
RSpec.describe 'Users', type: :system do
  
  describe 'ユーザー認証のテスト' do
    describe 'サインアップ' do
      before do
        visit new_learner_user_registration_path
      end
      context 'サインアップ後の遷移' do
        it '新規登録に成功する' do
          fill_in 'learner_user[name]', with: Faker::Internet.username(specifier: 6)
          fill_in 'learner_user[email]', with: Faker::Internet.email
          fill_in 'learner_user[password]', with: 'password'
          fill_in 'learner_user[password_confirmation]', with: 'password'
          click_button 'サインアップ'
          expect(page).to have_content 'ようこそ'
          expect(current_path).to eq(learner_welcome_path)

        end
        it '新規登録に失敗する' do
          fill_in 'learner_user[name]', with: ''
          fill_in 'learner_user[email]', with: ''
          fill_in 'learner_user[password]', with: ''
          fill_in 'learner_user[password_confirmation]', with: ''
          click_button 'サインアップ'
          expect(page).to have_content 'パスワード'
          expect(current_path).to eq(learner_user_registration_path)
          
        end
      end
    end
    describe 'ログイン' do
      let!(:test_user) { create(:user) }
      before do
        visit new_learner_user_session_path
      end
      context 'ログイン後の遷移' do
        # let(:test_user) { user }
        it 'ログインに成功する' do
          fill_in 'learner_user[email]', with: test_user.email
          fill_in 'learner_user[password]', with: test_user.password
          click_button 'ログイン'
          expect(page).to have_content 'ようこそ'
          expect(page).to have_content 'ようこそ'
          expect(current_path).to eq(learner_welcome_path)
        end

        it 'ログインに失敗する' do
          fill_in 'learner_user[email]', with: ''
          fill_in 'learner_user[password]', with: ''
          click_button 'ログイン'
          expect(page).to have_content 'ログイン'
          expect(current_path).to eq(new_learner_user_session_path)
        end
      end
    end
  end

  describe 'ユーザーのテスト' do
    let(:correct_user) { create(:user) }
    let!(:other_user) { create(:user) }
    before do
      visit new_learner_user_session_path
      fill_in 'learner_user[email]', with: correct_user.email
      fill_in 'learner_user[password]', with: correct_user.password
      click_button 'ログイン'
    end
    
    describe '編集のテスト' do
      context '自分の編集画面への遷移' do
        it '遷移できる' do
          visit edit_learner_user_path(correct_user)
          expect(current_path).to eq('/learner/users/' + correct_user.id.to_s + '/edit')
        end
      end
      context '他人の編集画面への遷移' do
        it '遷移できない' do
          visit edit_learner_user_path(other_user)
          expect(current_path).to eq('/')
        end
      end
    end
  end
end
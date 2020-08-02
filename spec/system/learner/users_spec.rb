require 'rails_helper'
RSpec.describe 'Users', type: :system do
  
  describe 'ユーザー認証のテスト' do
    describe 'ユーザー新規登録' do
      before do
        visit new_user_registration_path
      end
      context '新規登録画面に遷移' do
        it '新規登録に成功する' do
          fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
          fill_in 'user[email]', with: Faker::Internet.email
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button 'Sign up'

          expect(page).to have_content 'successfully'
        end
        it '新規登録に失敗する' do
          fill_in 'user[name]', with: ''
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          fill_in 'user[password_confirmation]', with: ''
          click_button 'Sign up'

          expect(page).to have_content 'error'
        end
      end
    end
    describe 'ユーザーログイン' do
      let(:user) { create(:user) }
      before do
        visit new_user_session_path
      end
      context 'ログイン画面に遷移' do
        let(:test_user) { user }
        it 'ログインに成功する' do
          fill_in 'user[name]', with: test_user.name
          fill_in 'user[password]', with: test_user.password
          click_button 'Log in'

          expect(page).to have_content 'successfully'
        end

        it 'ログインに失敗する' do
          fill_in 'user[name]', with: ''
          fill_in 'user[password]', with: ''
          click_button 'Log in'

          expect(current_path).to eq(new_user_session_path)
        end
      end
    end
  end

  describe 'ユーザーのテスト' do
    let(:user) { create(:user) }
    let!(:test_user2) { create(:user) }
    let!(:book) { create(:book, user: user) }
    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end
    
    describe '編集のテスト' do
      context '自分の編集画面への遷移' do
        it '遷移できる' do
          visit edit_user_path(user)
          expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
        end
      end
      context '他人の編集画面への遷移' do
        it '遷移できない' do
          visit edit_user_path(test_user2)
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
      end
      
    end
  end
end
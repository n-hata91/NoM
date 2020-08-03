require 'rails_helper'
RSpec.describe 'Articles', type: :system do
  describe '閲覧テスト'  do
    let(:user) { create(:user) }
    let(:movie) { create(:movie_article) }
    let!(:article) { create(:article, user_id: user.id, movie_id: movie.id) }
    context 'ログインしていない場合のアクセス' do
      it '一覧画面に遷移できない' do
        visit learner_articles_path
        expect(current_path).to eq(new_learner_user_session_path)
      end
      it '詳細画面に遷移できない' do
        visit learner_movie_article_path(movie.id, user.id)
        expect(current_path).to eq(new_learner_user_session_path)
      end
      it '新規投稿画面に遷移できない' do
        visit new_learner_movie_article_path(movie.id)
        expect(current_path).to eq(new_learner_user_session_path)
      end
      it '編集画面に遷移できない' do
        visit edit_learner_movie_article_path(movie.id, user.id)
        expect(current_path).to eq(new_learner_user_session_path)
      end
      it 'tipcorn投稿画面に遷移でない' do
        visit learner_tipcorn_path
        expect(current_path).to eq(new_learner_user_session_path)
      end
    end
  end

  describe '投稿のテスト' do
    let(:correct_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:movie) { create(:movie_article) }
    let(:tag) { create(:tag) }
    let!(:my_article) { create(:article, user_id: correct_user.id, movie_id: movie.id) }
    let!(:others_article) { create(:article, user_id: other_user.id, movie_id: movie.id) }
    let!(:new_article) { build(:article, user_id: correct_user.id, movie_id: movie.id) }
    before do
      visit new_learner_user_session_path
      fill_in 'learner_user[email]', with: correct_user.email
      fill_in 'learner_user[password]', with: correct_user.password
      click_button 'ログイン'
    end
    context '投稿の確認' do
      it '投稿に成功する' do
        visit new_learner_movie_article_path(movie.id)
        fill_in 'article_title', with: Faker::Lorem.characters(number:20)
        fill_in 'article_content', with: Faker::Lorem.characters(number:20)
        click_on '送信'
        expect(page).to have_content movie.title
        expect(current_path).to eq('/learner/movies/' + movie.id.to_s + '/articles/' + Article.last.id.to_s)
      end
      it '投稿に失敗する' do
        visit new_learner_movie_article_path(movie.id)
        fill_in 'article_title', with: ''
        fill_in 'article_content', with: ''
        click_on '送信'
        expect(page).to have_content '新規投稿'
      end
    end
    context '自分の投稿詳細画面の表示を確認' do
      it '投稿の編集/削除が表示される' do
        visit learner_movie_article_path(movie.id, my_article.id)
        expect(page).to have_link '編集' , href: edit_learner_movie_article_path(my_article.movie_id, my_article.id)
        expect(page).to have_link '削除' , href: learner_movie_article_path(my_article.movie_id, my_article.id)
      end
    end
    context '他人の投稿詳細画面の表示を確認' do
      it '投稿の編集リンクが表示されない' do
        visit learner_movie_article_path(movie.id, others_article.id)
        expect(page).to have_no_link '編集' , href: edit_learner_movie_article_path(movie.id, others_article.id)
        expect(page).to have_no_link '削除' , href: learner_movie_article_path(movie.id, others_article.id)
      end
    end
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_learner_movie_article_path(movie.id, my_article.id)
        expect(current_path).to eq('/learner/movies/' + movie.id.to_s + '/articles/' + my_article.id.to_s + '/edit')
      end
    end
    context '他人の編集画面への遷移' do
      it '遷移できない' do
        visit edit_learner_movie_article_path(movie.id, others_article.id)
        expect(current_path).to eq('/')
      end
    end
    it '編集に成功する' do
      visit edit_learner_movie_article_path(movie.id, my_article.id)
      fill_in 'article_title', with: Faker::Lorem.characters(number:20)
      fill_in 'article_content', with: Faker::Lorem.characters(number:20)
      click_on '送信'
      expect(page).to have_content movie.title
      expect(current_path).to eq('/learner/movies/' + movie.id.to_s + '/articles/' + my_article.id.to_s)
    end
    it '編集に失敗する' do
      visit edit_learner_movie_article_path(movie.id, my_article.id)
      fill_in 'article_title', with: ''
      fill_in 'article_content', with: ''
      click_on '送信'
      expect(page).to have_content '編集'
    end
  end
end
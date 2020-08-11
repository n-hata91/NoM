require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  describe 'コメントのテスト' do
    let!(:correct_user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:movie) { create(:movie_article) }
    let!(:article) { create(:article, user_id: other_user.id, movie_id: movie.id) }
    let!(:my_comment) { create(:comment, user_id: correct_user.id, article_id: article.id)}
    let!(:others_comment) { create(:comment,content: 'others', user_id: other_user.id, article_id: article.id)}
    let!(:new_comment) { build(:comment, user_id: correct_user.id, article_id: article.id)}
    before do
      visit new_learner_user_session_path
      fill_in 'learner_user[email]', with: correct_user.email
      fill_in 'learner_user[password]', with: correct_user.password
      click_button 'ログイン'
      visit learner_movie_article_path(article.movie_id, article.id)
    end
    context '自分のコメント欄で' do
      it 'コメント削除が表示される' do
        expect(page).to have_link nil , href: learner_movie_article_comment_path(article.movie_id, article.id, my_comment.id)
      end
      it 'コメントを削除' do
        within ".destroy_#{my_comment.id}" do
          link = find('a[data-method="delete"]')
          expect(page).to have_link nil , href: learner_movie_article_comment_path(article.movie_id, article.id, my_comment.id)
          link.click
          until has_css?('.bi-trash'); end
        end
        expect(page).not_to have_content(my_comment.content)
      end
    end
    context '他人のコメント欄に' do
      it 'コメントの削除が表示されない' do
        expect(page).to have_no_link nil , href: learner_movie_article_comment_path(article.movie_id, article.id, others_comment.id)
      end
    end
    context 'コメントの確認' do
      it 'コメントに成功する' do
        expect { 
          fill_in 'comment_content', with: 'comment'
          click_button 'コメント'
          sleep 0.5
        }.to change { Comment.count }.by(1)
      end
      it '空コメントは追加されない' do
        expect { 
          fill_in 'comment_content', with: ''
          click_button 'コメント'
          sleep 0.5
        }.to change { Comment.count }.by(0)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe 'Commentモデル', type: :model do
  describe 'バリデーションテスト' do
    let(:user) { create(:user)}
    let(:movie) { create(:movie_article) }
    let(:article) { create(:article, user_id: user.id, movie_id: movie.id) }
    let!(:comment) { build(:comment, user_id: user.id, article_id: article.id) }

    context 'user_id' do
      it '空でない' do
        comment.user_id = ''
        expect(comment.valid?).to eq false;
      end
    end
    context 'article_id' do
      it '空でない' do
        comment.article_id = ''
        expect(comment.valid?).to eq false;
      end
    end
    context 'content' do
      it '空でない' do
        comment.content = ''
        expect(comment.valid?).to eq false;
      end
      it '140文字以下である' do
        comment.content = Faker::Lorem.characters(number:141)
        expect(comment.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションテスト' do
    context 'userモデル' do
      it 'comment belongs_to' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'articleモデル' do
      it 'comment belongs_to' do
        expect(Comment.reflect_on_association(:article).macro).to eq :belongs_to
      end
    end
    context 'repliesモデル' do
      it 'comment has_many' do
        expect(Comment.reflect_on_association(:replies).macro).to eq :has_many
      end
    end
  end
end
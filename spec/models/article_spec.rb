require 'rails_helper'

RSpec.describe 'Articleモデル', type: :model do
  describe 'バリデーションテスト' do
    let(:user) { create(:user) }
    let(:movie1) { create(:movie_article) }
    let(:movie2) { create(:movie_tipcorn) }
    let!(:article) { build(:article, user_id: user.id, movie_id: movie1.id) }
    let!(:tipcorn) { build(:article, user_id: user.id, movie_id: movie2.id) }

    context 'user_id' do
      it '空でない' do
        article.user_id = ''
        tipcorn.user_id = ''
        expect(article.valid?).to eq false;
        expect(tipcorn.valid?).to eq false;
      end
    end
    context 'title' do
      it '空でない' do
        article.title = ''
        expect(article.valid?).to eq false;
        tipcorn.title = ''
        expect(tipcorn.valid?).to eq false;
      end
      it '50文字以下である' do
        article.title = Faker::Lorem.characters(number:51)
        expect(article.valid?).to eq false;
        tipcorn.title = Faker::Lorem.characters(number:51)
        expect(tipcorn.valid?).to eq false;
      end
    end
    context 'content' do
      it '空でない' do
        article.content = ''
        expect(article.valid?).to eq false;
        tipcorn.content = ''
        expect(tipcorn.valid?).to eq false;
      end
      it '400文字以下である' do
        article.content = Faker::Lorem.characters(number:401)
        expect(article.valid?).to eq false;
        tipcorn.content = Faker::Lorem.characters(number:401)
        expect(tipcorn.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションテスト' do
    context 'userモデル' do
      it 'article belongs_to' do
        expect(Article.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'movieモデル' do
      it 'article belongs_to' do
        expect(Article.reflect_on_association(:movie).macro).to eq :belongs_to
      end
    end
    context 'favoritesモデル' do
      it 'article has_many' do
        expect(Article.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'commentsモデル' do
      it 'article has_many' do
        expect(Article.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'repliesモデル' do
      it 'article has_many' do
        expect(Article.reflect_on_association(:replies).macro).to eq :has_many
      end
    end
    context 'article_tagsモデル' do
      it 'article has_many' do
        expect(Article.reflect_on_association(:article_tags).macro).to eq :has_many
      end
    end
    context 'tagsモデル' do
      it 'article has_many' do
        expect(Article.reflect_on_association(:tags).macro).to eq :has_many
      end
    end
  end
end
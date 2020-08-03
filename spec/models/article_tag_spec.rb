require 'rails_helper'

RSpec.describe 'ArticleTagモデル', type: :model do
  describe 'バリデーションテスト' do
    let(:user) { create(:user)}
    let(:movie) { create(:movie_article) }
    let!(:article) { create(:article, user_id: user.id, movie_id: movie.id) }
    let(:tag) { create(:tag) }
    let!(:article_tag) { build(:article_tag, article_id: article.id, tag_id: tag.id) }

    context 'article_id' do
      it '空でない' do
        article_tag.article_id = ''
        expect(article_tag.valid?).to eq false;
      end
    end
    context 'tag_id' do
      it '空でない' do
        article_tag.tag_id = ''
        expect(article_tag.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションテスト' do
    context 'articleモデル' do
      it 'article_tag belongs_to' do
        expect(ArticleTag.reflect_on_association(:article).macro).to eq :belongs_to
      end
    end
    context 'tagモデル' do
      it 'article_tag belongs_to' do
        expect(ArticleTag.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
  end
end
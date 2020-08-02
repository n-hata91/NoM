require 'rails_helper'

RSpec.describe 'Tagモデル', type: :model do
  describe 'バリデーションテスト' do
    let(:tag1) { create(:tag) }
    let(:tag2) { build(:tag) }

    context 'name' do
      it '空でない' do
        tag2.name = ''
        expect(tag2.valid?).to eq false;
      end
      it '重複しない' do
        tag2.name = tag1.name
        expect(tag2.valid?).to eq false;
      end
      it '20文字以下である' do
        tag2.name = Faker::Lorem.characters(number:21)
        expect(tag2.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションテスト' do
    context 'articlesモデル' do
      it 'tag has_many' do
        expect(Tag.reflect_on_association(:articles).macro).to eq :has_many
      end
    end
    context 'article_tagsモデル' do
      it 'tag has_many' do
        expect(Tag.reflect_on_association(:article_tags).macro).to eq :has_many
      end
    end
  end
end
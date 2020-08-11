require 'rails_helper'

RSpec.describe 'Userモデル', type: :model do

  describe 'バリデーションテスト' do
    let(:user) { create(:user) }
    subject { test_user.valid? }

    context 'name' do
      let(:test_user) { user }
      it '空でない' do
        test_user.name = ''
        is_expected.to eq false;
      end
      it '30文字以下である' do
        test_user.name = Faker::Lorem.characters(number:31)
        is_expected.to eq false;
      end
    end

    context 'introduction' do
      let(:test_user) { user }
      it '140文字以下である' do
        test_user.introduction = Faker::Lorem.characters(number:141)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションテスト' do
    context 'sns_oauthモデル' do
      it 'user has_many' do
        expect(User.reflect_on_association(:sns_credentials).macro).to eq :has_many
      end
    end
    context 'articleモデル' do
      it 'user has_many' do
        expect(User.reflect_on_association(:articles).macro).to eq :has_many
      end
    end
    context 'relationモデル' do
      it 'user has_many' do
        expect(User.reflect_on_association(:follow_to).macro).to eq :has_many
      end
      it 'user has_many' do
        expect(User.reflect_on_association(:follow_from).macro).to eq :has_many
      end
      it 'user has_many' do
        expect(User.reflect_on_association(:following).macro).to eq :has_many
      end
      it 'user has_many' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
    end
    context 'commentモデル' do
      it 'user has_many' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'favoriteモデル' do
      it 'user has_many' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
      it 'user has_many' do
        expect(User.reflect_on_association(:favorite_articles).macro).to eq :has_many
      end
    end
    context 'tagモデル' do
      it 'user has_many' do
        expect(User.reflect_on_association(:article_tags).macro).to eq :has_many
      end
    end
  end
end
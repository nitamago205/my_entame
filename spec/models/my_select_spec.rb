require 'rails_helper'

RSpec.describe 'MySelectモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { my_select.valid? }

    let(:user) { create(:user) }
    let(:genre) { create(:genre) }
    let(:post) { create(:post, user_id: user.id, genre_id: genre.id) }
    let(:my_select) { build(:my_select, post_id: post.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        my_select.title = ''
        is_expected.to eq false
      end
      it '50文字以下であること: 50文字は〇' do
        my_select.title = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 50文字は×' do
        my_select.title = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        my_select.body = ''
        is_expected.to eq false
      end
      it '300文字以下であること: 300文字は〇' do
        my_select.body = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it '300文字以下であること: 301文字は×' do
        my_select.body = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(MySelect.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
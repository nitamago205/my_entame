require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { genre.valid? }

    let(:genre) { create(:genre) }

    context 'genre_nameカラム' do
      it '空欄でないこと' do
        genre.genre_name = ''
        is_expected.to eq false
      end

      it '20文字以下であること: 20文字は〇' do
        genre.genre_name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end

      it '20文字以下であること: 20文字は×' do
        genre.genre_name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
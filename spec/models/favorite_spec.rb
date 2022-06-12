require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'バリデーションのテスト' do
    subject { favorite.valid? }

    let(:user) { create(:user) }
    let(:genre) { create(:genre) }
    let(:post) { create(:post, user_id: user.id, genre_id: genre.id) }
    let(:favorite) { user.favorites.build(post_id: post.id) }

    it 'いいねが存在している確認' do
      expect(favorite).to be_valid
    end


    it 'user_idとpost_itの組み合わせは一意である' do
      dupulicate_favorite = favorite.dup
      favorite.save
      expect(dupulicate_favorite).not_to be_valid
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end

end
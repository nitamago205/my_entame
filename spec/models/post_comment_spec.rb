require 'rails_helper'

RSpec.describe 'PostCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }

    let(:user) { create(:user) }
    let(:genre) { create(:genre) }
    let(:post) { create(:post, user_id: user.id, genre_id: genre.id) }
    let(:post_comment) { build(:post_comment, post_id: post.id, user_id: user.id) }

    context 'commentカラム' do
      it '空欄でないこと' do
        post_comment.comment = ''
        is_expected.to eq false
      end
      it '100文字以下であること: 100文字は〇' do
        post_comment.comment = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it '100文字以下であること: 100文字は×' do
        post_comment.comment = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end

    it 'コメントが存在している確認' do
      expect(post_comment).to be_valid
    end

    it 'user_idは空であってはいけない' do
      post_comment.user_id = nil
      expect(post_comment).not_to be_valid
    end

    it 'post_idは空であってはいけない' do
      post_comment.post_id = nil
      expect(post_comment).not_to be_valid
    end


  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(PostComment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
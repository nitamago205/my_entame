require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:relationship) { user.relationships.build(followed_id: other_user.id) }

  it 'Relationshipが存在しているかどうか' do
    expect(relationship).to be_valid
  end

  it 'follower_idが空ではない' do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it 'followed_idが空ではない' do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
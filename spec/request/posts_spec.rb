require 'rails_helper'

RSpec.describe "Posts", type: :request do
  # FactoryBotのテストデータを使ってuserとpostのデータを作成
  let!(:user) { create(:user) }
  let!(:genre) { create(:genre) }
  let!(:post) { create(:post, user_id: user.id, genre_id: genre.id) }

  describe "GET /new" do
    it "returns http success" do
      sign_in user
      get new_post_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get posts_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get post_path(post)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      sign_in user
      get edit_post_path(post)
      expect(response).to have_http_status(200)
    end
  end
end
class Public::FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.new(post_id: @post.id)
    @favorite.save
    # @q = Post.ransack(params[:q])
    # @user = User.find(params[:user_id])
    # @favorite_posts = @q.result(distinct: true).joins(:favorites).where(favorites: {user_id: @user.id}).page(params[:favorite_posts_page]).per(6).order(created_at: "DESC")
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @favorite.destroy
    # @q = Post.ransack(params[:q])
    # @user = User.find(params[:user_id])
    # @favorite_posts = @q.result(distinct: true).joins(:favorites).where(favorites: {user_id: @user.id}).page(params[:favorite_posts_page]).per(6).order(created_at: "DESC")
  end
end

class Admin::PostsController < ApplicationController
  def index
    if params[:latest]
     @posts = Post.latest
    elsif params[:old]
     @posts = Post.old
    elsif params[:star_count]
     @posts = Post.star_count
    else
     @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @selects = MySelect.where(post_id: @post.id)
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_posts_path
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :rate, :genre_id)
  end

end

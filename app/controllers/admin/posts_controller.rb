class Admin::PostsController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(10)
    @genres = Genre.all
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
    @genres = Genre.all
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_user_path(@post.user)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :rate, :genre_id)
  end

end

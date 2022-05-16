class Public::PostsController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(10)
    @genres = Genre.all
  end

  def show
    @post = Post.find(params[:id])
    @selects = MySelect.where(post_id: @post.id)
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @genres = Genre.all

    @post.rate = 0 if @post.rate.blank?
    if @post.save
      redirect_to post_path(@post), notice: "新しく投稿しました。"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    @genres = Genre.all
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to user_path(current_user), notice: "投稿を削除しました。"
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :rate, :genre_id)
  end


end

class Public::MySelectsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user
  def new
    @post = Post.find(params[:post_id])
    @select = MySelect.new
  end

  def create
    @select = MySelect.new(my_select_params)
    @post = Post.find(params[:post_id])
    @select.post_id = @post.id
    if @select.save
      redirect_to post_path(@select.post_id), notice: "マイセレクトを追加しました。"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @select = MySelect.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @select = MySelect.find(params[:id])
    if @select.update(my_select_params)
      redirect_to post_path(@select.post_id), notice: "マイセレクトを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @select = MySelect.find_by(id: params[:id], post_id: params[:post_id])
    if @select.destroy
      redirect_to post_path(@select.post_id), notice: "マイセレクトを削除しました。"
    end
  end

  private

  def my_select_params
    params.require(:my_select).permit(:title, :body)
  end

  def ensure_correct_user
    @post = Post.find(params[:post_id])
    @select = MySelect.find(params[:id])
    unless @post.user == current_user && @post.id == @select.post_id
      redirect_to posts_path, notice: "権限がありません。"
    end
  end

end

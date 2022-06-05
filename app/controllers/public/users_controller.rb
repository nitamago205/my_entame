class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :confirm, :out]
  before_action :ensure_correct_user, only: [:edit, :update, :confirm, :out]
  before_action :ensure_normal_user, only: [:out, :update]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).where(is_deleted: false).page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
    @genres = Genre.all

    @q = Post.ransack(params[:q])
    # @q = @user.posts.ransack(params[:q])
    # 投稿一覧
    @posts = @q.result(distinct: true).where(user_id: @user).page(params[:posts_page]).per(6).order(created_at: "DESC")
    # いいね一覧
    @favorite_posts = @q.result(distinct: true).joins(:favorites).where(favorites: {user_id: @user.id}).page(params[:favorite_posts_page]).per(6).order(created_at: "DESC")
    # コメント一覧
    @comment_posts = @q.result(distinct: true).joins(:post_comments).where(post_comments: {user_id: @user.id}).page(params[:comment_posts_page]).per(6).order(created_at: "DESC")
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render "edit"
    end
  end

  def confirm
    @user = current_user
  end

  def out
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :is_deleted)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to posts_path, notice: "権限がありません。"
    end
  end

  def ensure_normal_user
    @user = User.find(params[:id])
    if current_user.email == 'guest@example.com'
      redirect_to user_path(@user), alert: 'ゲストユーザーはユーザー情報の編集、退会ができません。'
    end
  end

end

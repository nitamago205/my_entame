class Public::UsersController < ApplicationController
  before_action :ensure_normal_user, only: [:out, :update]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).where(is_deleted: false).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @q = @user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(10)
    @genres = Genre.all
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

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーはユーザー情報の編集、退会ができません。'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :is_deleted)
  end



end

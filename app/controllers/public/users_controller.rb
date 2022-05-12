class Public::UsersController < ApplicationController
  def index
    @users = User.where(is_deleted: false).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    if params[:latest]
     @posts = @user.posts.latest
    elsif params[:old]
     @posts = @user.posts.old
    elsif params[:star_count]
     @posts = @user.posts.star_count
    else
     @posts = @user.posts
    end
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
    params.require(:user).permit(:name, :profile_image, :is_deleted)
  end



end

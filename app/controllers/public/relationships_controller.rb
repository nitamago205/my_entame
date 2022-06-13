class Public::RelationshipsController < ApplicationController
  # フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
    #通知機能
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
  end
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(10)
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(10)
  end
end

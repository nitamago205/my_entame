class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comments = @post.post_comments.page(params[:post_comment_page]).per(5).order(created_at: "DESC")
    if @post_comment.save
      @message = "コメントしました。"
      #通知機能
      @post.create_notification_post_comment!(current_user, @post_comment.id)
    end
  end

  def destroy
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.page(params[:post_comment_page]).per(5).order(created_at: "DESC")
    if @post_comment.destroy
      @message = "コメントを削除しました。"
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

module Public::NotificationsHelper
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @post_comment = nil
    @visitor_post_comment = notification.post_comment_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'があなたをフォローしました'
    when 'favorite'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'が' + tag.a(notification.post.title, href: post_path(notification.post_id)) + 'にいいねしました'
    when 'post_comment' then
      #コメントの内容と投稿のタイトルを取得
      @post_comment = PostComment.find_by(id: @visitor_post_comment)
      @post_comment_comment =@post_comment.comment
      @post_title =@post_comment.post.title
      tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@post_title}", href: post_path(notification.post_id)) + 'にコメントしました'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
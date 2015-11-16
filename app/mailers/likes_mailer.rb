class LikesMailer < ApplicationMailer

  def notify_post_creator(like)
    @post = like.post
    @owner = like.post.user
    @total_likes = @post.likes.count
    if @owner.email.present?
      mail(to: @owner.email, subject: "Your post has a new like!")
    end
  end

  def notify_comment_creator(commentlike)
    @comment = commentlike.comment
    @owner = commentlike.comment.user
    @total_likes = @comment.commentlikes.count
    if @owner.email.present?
      mail(to: @owner.email, subject: "Your comment has a new like!")
    end
  end

end

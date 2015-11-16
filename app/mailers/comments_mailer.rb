class CommentsMailer < ApplicationMailer

  def notify_post_creator(comment)
    @post = comment.post
    @owner = comment.post.user
    if @owner.email.present?
      mail(to: @owner.email, subject: "You've got a new comment!")
    end
  end

end

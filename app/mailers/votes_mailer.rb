class VotesMailer < ApplicationMailer

  def notify_post_creator(vote)
    @post = vote.post
    @owner = @post.user
    @total_votes = @post.vote_total
    if @owner.email.present?
      mail(to: @owner.email, subject: "You've got a new vote!")
    end
  end

  def notify_comment_creator(vote)
    @comment = vote.comment
    @owner = @comment.user
    @total_votes = @comment.vote_total
    if @owner.email.present?
      mail(to: @owner.email, subject: "You've got a new vote!")
    end
  end

end

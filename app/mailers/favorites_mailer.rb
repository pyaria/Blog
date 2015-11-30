class FavoritesMailer < ApplicationMailer

  def notify_post_creator(favorite)
    @post = favorite.post
    @owner = favorite.post.user
    @total_favorites = @post.favorites.count
    if @owner.email.present?
      mail(to: @owner.email, subject: "You've got a new favorite!")
    end
  end

end

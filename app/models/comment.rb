class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, length: {minimum: 5}, presence: true
  validates :post, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails

  private

  def send_favorite_emails
    post.favorites.each do |favorite|
      FavoriteMailer.new_comment(favorite.user, post, self).deliver
    end
  end

       # allow( FavoriteMailer )
       #  .to receive(:new_comment)
       #  .with(@user, @post, @comment)
       #  .and_return( double(deliver: true))

end

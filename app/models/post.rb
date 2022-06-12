class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :my_selects, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence:true, length:{maximum:50}
  validates :body, presence:true, length:{maximum:500}

  def favorited_by?(user)
   favorites.where(user_id: user.id).exists?
  end
  
  # いいね順の並び替えで定義
  ransacker :favorites_count do
  query = '(SELECT COUNT(favorites.post_id) FROM favorites where favorites.post_id = posts.id GROUP BY favorites.post_id)'
  Arel.sql(query)
end
end

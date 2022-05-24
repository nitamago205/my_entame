class Genre < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :genre_name, presence:true, length:{maximum:20}
end

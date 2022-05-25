class MySelect < ApplicationRecord
  belongs_to :post

  validates :title,presence:true, length:{maximum:50}
  validates :body,presence:true, length:{maximum:300}
end

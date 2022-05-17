class MySelect < ApplicationRecord
  belongs_to :post

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end

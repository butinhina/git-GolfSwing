class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post_video
  #バリデーションの設定
  validates :comment, presence: true
end

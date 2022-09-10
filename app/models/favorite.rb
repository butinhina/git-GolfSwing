class Favorite < ApplicationRecord
  # バリデーションの設定
  validates :customer_id, uniqueness: { scope: :post_video_id }
  belongs_to :customer
  belongs_to :post_video
end

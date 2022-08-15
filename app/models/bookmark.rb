class Bookmark < ApplicationRecord
  belongs_to :customer
  belongs_to :post_video

  validates :customer_id, uniqueness: { scope: :post_video_id }
end

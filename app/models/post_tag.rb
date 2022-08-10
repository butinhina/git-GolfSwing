class PostTag < ApplicationRecord
  belongs_to :post_video
  belongs_to :tag
end

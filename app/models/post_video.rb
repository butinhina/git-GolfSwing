class PostVideo < ApplicationRecord

  has_one_attached :video
  belongs_to :customer

  def get_video
    if video.attached?
      video
    end
  end
end

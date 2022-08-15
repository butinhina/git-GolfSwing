class PostVideo < ApplicationRecord

  has_one_attached :video
  belongs_to :customer

  #post_videosテーブルから中間テーブルに対する関連付け
  has_many :post_tags, dependent: :destroy
  #post_videosテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :post_tags, dependent: :destroy
  #post_videosテーブルから中間テーブルに対する関連付け
  has_many :bookmarks, dependent: :destroy

  def get_video
    if video.attached?
      video
    end
  end

  def self.search(keyword)
      where(["report like? OR created_at like?", "%#{keyword}%", "%#{keyword}%"])
  end

  # 既にブックマークしているかを検証
  def bookmarked_by?(customer)
    bookmarks.where(customer_id: customer).exists?
  end
end

class PostVideo < ApplicationRecord

  has_one_attached :video
  belongs_to :customer

  #post_videosテーブルから中間テーブルに対する関連付け
  has_many :post_tags, dependent: :destroy
  #post_videosテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :post_tags, dependent: :destroy
  #post_videosテーブルから中間テーブルに対する関連付け
  has_many :bookmarks, dependent: :destroy
  #post_videosテーブルから中間テーブルに対する関連付け
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  # バリデーションの設定
  validates :video, presence: true
  
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
  # 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するか
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  enum status: { published: 0, draft: 1 }
end

class PostVideo < ApplicationRecord

  has_one_attached :video
  belongs_to :customer
  #post_videosテーブルから中間テーブルに対する関連付け
  has_many :post_tags, dependent: :destroy
  #post_videosテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :post_tags, dependent: :destroy
  #post_videosテーブルから中間テーブルに対する関連付け
  has_many :bookmarks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  # バリデーションの設定
  validates :video, presence: true
  validate :video_type, :video_size

  def get_video
    if video.attached?
      video
    end
  end
  #どちらか一方にでも検索キーワードが部分一致すれば、その記事を出力する。
  def self.search(keyword)
    where(["report like? OR created_at like?", "%#{keyword}%", "%#{keyword}%"])
  end

  # 既にブックマークしているかを検証
  def bookmarked_by?(customer)
    bookmarks.where(customer_id: customer).exists?
  end
  # 既にいいねしているかを検証
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer)
  end
  #投稿と下書き
  enum status: { published: 0, draft: 1 }

  private

  def video_type
    if !video.blob.content_type.in?(%('video/mp4'))
      errors.add(:video, "はmp4でアップロードしてください")
    end
  end

  def video_size
    if video.blob.byte_size > 5.megabytes
      errors.add(:video, "は1つのファイル5MB以内にしてください")
    end
  end
end

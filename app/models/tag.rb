class Tag < ApplicationRecord
  #Tagsテーブルから中間テーブルに対する関連付け
  has_many :post_tags, dependent: :destroy
  #Tagsテーブルから中間テーブルを介してArticleテーブルへの関連付け
  has_many :post_videos, through: :post_tags, dependent: :destroy
  # バリデーションの設定
  validates :name,  length: { minimum: 1, maximum: 10 }
end

class Bookmark < ApplicationRecord
  #バリデーションの設定 ロード中に２度以上連続で登録しようとすることを防ぐ
  validates :customer_id, uniqueness: { scope: :post_video_id }
end

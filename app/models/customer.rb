class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  # customerテーブルから中間テーブルに対する関連付け
  has_many :post_videos, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # バリデーションの設定
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :nickname, presence: true
  validate :profile_image_size, :profile_image_type

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpeg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by(email: "guest@example.com") do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = "ゲスト"
      customer.first_name = "ゲスト"
      customer.last_name_kana = "ゲスト"
      customer.first_name_kana = "ゲスト"
      customer.nickname = "ゲスト"
    end
  end

  private

  def profile_image_size
    # byebug
    return true if self.email == "guest@example.com"
    if !profile_image.attached?
      profile_image.attach(io: File.open("#{Rails.root.join}/app/assets/images/no_image.jpeg"),filename: "default-image.jpg", content_type: "image/jpeg")
    elsif profile_image.blob.byte_size > 1.megabytes
      errors.add(:profile_image, "は1つのファイル1MB以内にしてください")
    end
  end

  def profile_image_type
    return true if self.email == "guest@example.com"
      if !profile_image.blob.content_type.in?(%('image/jpg image/png image/jpeg'))
       errors.add(:profile_image, "はjpegまたはpng形式でアップロードしてください")
      end
  end
end

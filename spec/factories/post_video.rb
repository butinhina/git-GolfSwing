FactoryBot.define do
  factory :post_video do
    video { ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/swings/ひなぽんスウィング.mp4"), filename:"ひなぽんスウィング.mp4") }
    report { "ゴルフ" }
  end
end
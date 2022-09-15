# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tag.create([
  { name: 'ドライバー'},
  { name: 'ウッド'},
  { name: 'ユーティリティー'},
  { name: 'アイアン'},
  { name: 'アプローチ'},
  { name: 'パター'},
  { name: 'バンカー'},
  { name: '前方'},
  { name: '後方'},
  { name: 'フェード'},
  { name: 'ドロー'},
  { name: 'スライス'},
  { name: 'フック'},
  { name: 'ダウンブロー'},
  { name: '練習場'},
  { name: 'コース'}
  ])

Admin.create(
  email: 'a@a',
  password: 'aaaaaa'
  )

customers = Customer.create(
  [
    {email: 'o@o', last_name: 'Olivia', first_name: 'hinaka', last_name_kana: 'オリビア', first_name_kana: 'ヒナカ', password: 'oooooo', nickname: 'hinapon', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/profile_image/IMG_9378.jpg"), filename:"IMG_9378.jpg")},
    {email: 'j@j', last_name: 'James', first_name: 'hitoshi', last_name_kana: 'ジェイムズ', first_name_kana: 'ヒトシ', password: 'jjjjjj', nickname: 'zin', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/profile_image/IMG_9908.jpg"), filename:"IMG_9908.jpg")},
    {email: 'l@l', last_name: 'Lucas', first_name: 'yosuke', last_name_kana: 'ルカズ', first_name_kana: 'ヨウスケ', password: 'llllll', nickname: 'suke', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/profile_image/IMG_9910.jpg"), filename:"IMG_9910.jpg")}
  ]
)

PostVideo.create(
  [
    {report: '2022.03.28 ひなぽんスウィング', customer_id: "1", video: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/swings/ひなぽんスウィング.mp4"), filename:"ひなぽんスウィング.mp4")},
    {report: '2020.08.05 じんスウィング', customer_id: "2", video: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/swings/じんくん後方.mp4"), filename:"じんくん後方.mp4")},
    {report: '2021.09.21 すけスウィング', customer_id: "3", video: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/swings/ひなぽんアプローチ.mp4"), filename:"ひなぽんアプローチ.mp4")}
  ]
)

require 'rails_helper'

describe 'PostVideoに関するテスト' do
  before do
    @customer = FactoryBot.create(:customer)
     
    @post_video = create(:post_video, customer_id: @customer.id)
   

  # ユーザーAでログインする
    visit new_customer_session_path
    fill_in "メールアドレス", with: @customer.email
    fill_in "パスワード", with: @customer.password
    click_button 'ログイン'

  end
  context '投稿がうまくいく時' do
    # byebug
    it 'ログインしたユーザーは投稿できる' do
      visit new_public_post_video_path
      attach_file "post_video[video]", "#{Rails.root}/db/swings/ひなぽんスウィング.mp4"
      fill_in "post_video[report]", with: @post_video.report
      click_button "OK"
     
      visit public_post_video_path(@post_video)
    end
  end
end
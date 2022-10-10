# frozen_string_literal: true

require 'rails_helper'

describe 'Customerに関するテスト' do
  context "新規登録がうまくいく時" do
    it "内容に問題ない場合は登録される" do
      expect(FactoryBot.build(:customer)).to be_valid
    end
    it 'emailは全て小文字で保存される' do
      customer = FactoryBot.build(:customer)
      customer.email = 'SAMPLE@SAMPLE.JP'
      customer.save
      expect(customer.email).to eq 'sample@sample.jp'
    end
  end

  context "新規登録がうまくいかない時" do
    it "nicknameがない場合は登録できないこと" do
      customer = build(:customer, nickname: nil)
      expect(customer).to be_invalid
      expect(customer.errors[:nickname]).to include("が入力されていません。")
    end
    it "emailがない場合は登録できないこと" do
      customer = build(:customer, email: nil)
      expect(customer).to be_invalid
      expect(customer.errors[:email]).to include("が入力されていません。")
    end

    it "パスワードがない場合は登録できないこと" do
      customer = build(:customer, password: nil)
      expect(customer).to be_invalid
      expect(customer.errors[:password]).to include("が入力されていません。")
    end
  end

    it "重複したemailが存在する場合は登録できない" do
      customer = FactoryBot.create(:customer)
      another_customer = FactoryBot.build(:customer)
      another_customer.email = customer.email
      expect(another_customer).to be_invalid
      expect(another_customer.errors[:email]).to include("は既に使用されています。")
    end
    it "パスワードが5文字以下の場合は登録できないこと" do
      customer = build(:customer, password: "00000")
      password_min_length = Customer.password_length.first
      expect(customer).to be_invalid
      expect(customer.errors[:password]).to include("は#{password_min_length}文字以上に設定して下さい。")
    end
    it "passwordが存在してもpassword_confirmationが空の場合は登録できない" do
      customer = build(:customer, password_confirmation: "")
      expect(customer).to be_invalid
      expect(customer.errors[:password_confirmation]).to include("が内容とあっていません。")
    end

    it "passwordとpassword_confirmationの内容が一致しない場合は登録できない" do
      customer = build(:customer, password: "00000", password_confirmation: "000001")
      expect(customer).to be_invalid
      expect(customer.errors[:password_confirmation]).to include("が内容とあっていません。")
    end
end
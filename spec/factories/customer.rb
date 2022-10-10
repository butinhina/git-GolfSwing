FactoryBot.define do
  factory :customer do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end

end
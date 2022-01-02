FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test@user.com' }
    password { 'user' }
  end
end

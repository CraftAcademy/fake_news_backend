FactoryBot.define do
  factory :journalist do
    email { "journalist@random.com" }
    password { "password" }
    password_confirmation { "password" }
    role { 2 }
  end
end

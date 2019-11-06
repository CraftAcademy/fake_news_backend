FactoryBot.define do
  factory :category do
    category { "CategoryString" }
    association :article
  end
end

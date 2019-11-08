FactoryBot.define do
  factory :article do
    title { "TitleString" }
    content { "ContentText" }
    
    association :journalist, factory: :user
    association :category

    after(:build) do |object|
      object.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy-img-1.png')), filename: "dummy-img-1.png", content_type: 'image/png')
    end 
  end
end
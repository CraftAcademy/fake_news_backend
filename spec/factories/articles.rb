FactoryBot.define do
  factory :article do
    title { "TitleString" }
    content { "ContentText" }
    after(:build) do |object|
      object.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy-img.png')), filename: "dummy-img.png", content_type: 'image/png')
    end 
  end
end
users = User.create(email: 'user@mail.com', password: 'password')
journalist = User.create(email: 'journalist@mail.com', password: 'password', role: 'journalist')
subscriber = User.create(email: 'subscriber@mail.com', password: 'password', role: 'subscriber')

category_1 = Category.create( name: 'Sports')
category_2 = Category.create( name: 'Politics')
category_3 = Category.create( name: 'Tech')
category_4 = Category.create( name: 'Economics')
category_5 = Category.create( name: 'Lifestyle')
category_6 = Category.create( name: 'Leisure')

2.times do
  Article.create(
    title: Faker::Book.title
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    journalist_id: rand(100)
    category: category_1
    image: Faker::LoremFlickr.image
  )
end

2.times do
  Article.create(
    title: Faker::Book.title
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    journalist_id: rand(100)
    category: category_2
    image: Faker::LoremFlickr.image
  )
end

2.times do
  Article.create(
    title: Faker::Book.title
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    journalist_id: rand(100)
    category: category_3
    image: Faker::LoremFlickr.image
  )
end

2.times do
  Article.create(
    title: Faker::Book.title
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    journalist_id: rand(100)
    category: category_4
    image: Faker::LoremFlickr.image
  )
end

2.times do
  Article.create(
    title: Faker::Book.title
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    journalist_id: rand(100)
    category: category_5
    image: Faker::LoremFlickr.image
  )
end

2.times do
  Article.create(
    title: Faker::Book.title
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    journalist_id: rand(100)
    category: category_6
    image: Faker::LoremFlickr.image
  )
end

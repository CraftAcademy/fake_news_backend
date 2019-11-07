User.destroy_all

user = User.create(email: 'user@mail.com', encrypted_password: 'password', role: 'user')
journalist = User.create(email: 'journalist@mail.com', password: 'password', role: 'journalist')
subscriber = User.create(email: 'subscriber@mail.com', password: 'password', role: 'subscriber')

category_1 = Category.create( name: 'Sports')
category_2 = Category.create( name: 'Politics')
category_3 = Category.create( name: 'Tech')
category_4 = Category.create( name: 'Economics')
category_5 = Category.create( name: 'Lifestyle')
category_6 = Category.create( name: 'Leisure')

2.times do
  article = Article.create(
    title: Faker::Book.title,
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    journalist_id: journalist.id,
    category: category_1,
  )
  article.image.attach(io: File.open('spec/fixtures/dummy-img-1.png'), filename: 'dummy-img-1.png')
end

2.times do
  article = Article.create(
    title: Faker::Book.title,
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    journalist_id: journalist.id,
    category: category_2,
  )
  article.image.attach(io: File.open('spec/fixtures/dummy-img-2.png'), filename: 'dummy-img-2.png')
end

2.times do
  article = Article.create(
    title: Faker::Book.title,
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    journalist_id: journalist.id,
    category: category_3,
  )
  article.image.attach(io: File.open('spec/fixtures/dummy-img-3.png'), filename: 'dummy-img-3.png')
end

2.times do
  article = Article.create(
    title: Faker::Book.title,
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    journalist_id: journalist.id,
    category: category_4,
  )
  article.image.attach(io: File.open('spec/fixtures/dummy-img-4.png'), filename: 'dummy-img-4.png')
end

2.times do
  article = Article.create(
    title: Faker::Book.title,
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    journalist_id: journalist.id,
    category: category_5,
  )
  article.image.attach(io: File.open('spec/fixtures/dummy-img-5.png'), filename: 'dummy-img-5.png')
end

2.times do
  article = Article.create(
    title: Faker::Book.title,
    content: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    journalist_id: journalist.id,
    category: category_6,
  )
  article.image.attach(io: File.open('spec/fixtures/dummy-img-6.png'), filename: 'dummy-img-6.png')
end
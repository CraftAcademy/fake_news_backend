users = User.create(email: 'user@mail.com', password: 'password')
journalist = User.create(email: 'journalist@mail.com', password: 'password', role: 'journalist')
subscriber = User.create(email: 'subscriber@mail.com', password: 'password', role: 'subscriber')
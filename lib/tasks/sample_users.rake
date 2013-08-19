namespace :db do
  desc 'Fill database with sample users and tutors'
  task populate: :environment do
    User.create!(first_name: 'Daniele',
                last_name: 'Pestilli',
                email: 'byakugan.87@gmail.com',
                gender: 'male',
                password: 'tecredoo0',
                password_confirmation: 'tecredoo0')
    99.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "example-#{n+1}@railstutorial.org"
      password = 'foobar000'
      gender = ['male', 'female'].sample
      User.create!(first_name: first_name,
                  last_name: last_name,
                  email: email,
                  password: password,
                  password_confirmation: password,
                  gender: gender)
    end
    
    50.times do |n|
      user_id = n+1
      #sc = rand(2..11)
      #description = Faker::Lorem.sentences(sentence_count = sc)
      description = 'Some random description'
      rate = rand(10.0..60.0)
      country = ['Italy', 'France', 'Korea, Republic of', 'Hong Kong', 'Japan'].sample
      Tutor.create!(user_id: user_id,
                    description: description,
                    rate: rate,
                    country: country)
    end
  end
end
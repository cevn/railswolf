namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      user = User.new(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)

      if user.save 
        user.character.latitude = 37.2708
        user.character.longitude = -76.7092
        user.character.name = user.name 
        user.character.save 
      end
    end
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
			 UID: 111111111,
			 admin: 5,
			 activated: true,
             activated_at: Time.zone.now,
			 birthdate:Time.parse('1940-03-04'),
			 permanent_address:Faker::Lorem.sentence(4),
			 current_address:Faker::Lorem.sentence(4),
			 emergency_name:Faker::Name.name,
			 emergency_phone:"222-222-2222",
			 emergency_email:Faker::Internet.email,
			 phone:"301-333-2323")
User.create!(name:  "Example User",
             email: "wguo1@umd.edu",
             password:              "foobar",
             password_confirmation: "foobar",
			 UID: 111111111,
			 admin: 5,
			 activated: true,
             activated_at: Time.zone.now,
			 birthdate:Time.parse('1940-03-04'),
			 permanent_address:Faker::Lorem.sentence(4),
			 current_address:Faker::Lorem.sentence(4),
			 emergency_name:Faker::Name.name,
			 emergency_phone:"222-222-2222",
			 emergency_email:Faker::Internet.email,
			 phone:"301-333-2323")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
			   UID: rand(111111111..999999999),
			   activated: true,
               activated_at: Time.zone.now,
			   birthdate:Time.parse('1940-03-04'),
			   permanent_address:Faker::Lorem.sentence(4),
			   current_address:Faker::Lorem.sentence(4),
			   emergency_name:Faker::Name.name,
			   emergency_phone:"222-222-2222",
			   emergency_email:Faker::Internet.email,
			   phone:"301-222-4523")
end

users = User.order(:created_at).take(6)
20.times do
  content = Faker::Lorem.sentence(20)
  title = Faker::Lorem.word
  capacity = Faker::Number.digit
  users.each { |user| user.trips.create!(content: content, title: title, max_capacity: capacity) }
end


users = User.order(:created_at).take(6)
users.each { |user|
	color = Faker::Color.color_name
	year = Faker::Number.between(1998, 2018)
	make = Faker::Lorem.word
	model = Faker::Lorem.word
	license = Faker::Lorem.characters(10)
	state = Faker::Address.state
	capacity = Faker::Number.between(1, 7)
	user.create_car(color: color, year: year, make: make, model: model, license: license, state: state, capacity: capacity)
}

users = User.all
trips = Trip.all
user = users.first
trips[50..100].each { |trip| user.follow(trip)}
users[2..50].each {|other_user| other_user.follow(trips.last)}

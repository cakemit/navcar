# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Deleting user, car and rental databases"

User.destroy_all
Car.destroy_all
Rental.destroy_all

puts "Database deleted"

puts "Seeding database"

user = User.create!(
    first_name: "user",
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.full_address,
    email: "user@teste.com",
    password: '123456',
    password_confirmation: '123456'
    )
5.times do
  car = Car.create!(
      user_id: user.id ,
      brand: Faker::Vehicle.manufacture,
      model: Faker::Vehicle.model,
      year: Faker::Vehicle.year,
      km: Faker::Vehicle.kilometrage,
      daily_rate: rand(400..2000),
      city: Faker::Address.full_address,
      category: ["Vintage", "Luxury", "Off-road", "Sport"].sample
    )
  rental = Rental.create!(
      user_id: user.id,
      car_id: car.id,
      start_date: Date.today,
      finish_date: Faker::Date.between(from: Date.today, to: '2100-01-01')
    )
end


User.create!(
    first_name: "owner",
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.full_address,
    email: "owner@teste.com",
    password: '123456',
    password_confirmation: '123456'
    )

5.times do
  car = Car.create!(
      user_id: user.id ,
      brand: Faker::Vehicle.manufacture,
      model: Faker::Vehicle.model,
      year: Faker::Vehicle.year,
      km: Faker::Vehicle.kilometrage,
      daily_rate: rand(400..2000),
      city: Faker::Address.full_address,
      category: ["Vintage", "Luxury", "Off-road", "Sport"].sample
    )
  rental = Rental.create!(
      user_id: user.id,
      car_id: car.id,
      start_date: Date.today,
      finish_date: Faker::Date.between(from: Date.today, to: '2100-01-01')
    )

end

User.create!(
    first_name: "admin",
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.full_address,
    email: "admin@teste.com",
    password: '123456',
    password_confirmation: '123456'
    )

5.times do
  car = Car.create!(
      user_id: user.id ,
      brand: Faker::Vehicle.manufacture,
      model: Faker::Vehicle.model,
      year: Faker::Vehicle.year,
      km: Faker::Vehicle.kilometrage,
      daily_rate: rand(400..2000),
      city: Faker::Address.full_address,
      category: ["Vintage", "Luxury", "Off-road", "Sport"].sample
    )
  rental = Rental.create!(
      user_id: user.id,
      car_id: car.id,
      start_date: Date.today,
      finish_date: Faker::Date.between(from: Date.today, to: '2100-01-01')
    )

end


5.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.full_address,
    email: Faker::Internet.email,
    password: '123456',
    password_confirmation: '123456'
  )

  5.times do
    car = Car.create!(
      user_id: user.id,
      brand: Faker::Vehicle.manufacture,
      model: Faker::Vehicle.model,
      year: Faker::Vehicle.year,
      km: Faker::Vehicle.kilometrage,
      daily_rate: rand(400..2000),
      city: Faker::Address.full_address,
      category: ["Vintage", "Luxury", "Off-road", "Sport"].sample
    )
    rental = Rental.create!(
      user_id: user.id,
      car_id: car.id,
      start_date: Date.today,
      finish_date: Faker::Date.between(from: Date.today, to: '2100-01-01')
    )
    puts "Created car #{car.brand} - #{car.model} - #{car.year} - #{car.km}km"
    puts "Created rent #{rental.start_date} - #{rental.finish_date}"
  end
end
puts "Created #{User.count} users"
puts "Created #{Car.count} cars"
puts "Created #{Rental.count} rentals"

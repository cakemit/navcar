# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Deleting car database"

Car.destroy_all

puts "Database deleted"

puts "Seeding database"

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
        user_id: user.id ,
        brand: Faker::Vehicle.manufacture,
        model: Faker::Vehicle.model,
        year: Faker::Vehicle.year,
        km: Faker::Vehicle.kilometrage,
        daily_rate: rand(400..2000),
        city: Faker::Address.full_address
      )
  puts "Created car #{car.brand} - #{car.model} - #{car.year} - #{car.km}km"
end
end

puts "Created #{Car.count} cars"

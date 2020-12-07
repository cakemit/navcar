
puts " "
puts "Cleaning user, car and rental databases"
puts "..."

User.destroy_all
Car.destroy_all
Rental.destroy_all

puts "Databases are clean!"
puts " "

puts "START SEEDING (1) owner with cars, (2) user with rentals, and (3) admin account:"
puts " "
Faker::Config.locale = 'pt-BR'

# ------------------------------------------------------------------------------
puts "(1) Creating an owner with 8 cars"
puts " "

owner = User.create!(
  first_name: "OwnerNome",
  last_name: "OwnerSobrenome",
  phone: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.full_address,
  email: "owner@teste.com",
  password: '123456',
  password_confirmation: '123456'
)
puts "CREATED USER_ID: #{owner.id} - #{owner.email} (pw:123456) AS #{owner.first_name} ADDRESS #{owner.address}"
puts " "

# Create 2 cars with photos in each category
categories = ["Vintage", "Luxury", "Off-road", "Sport"]
2.times do
  categories.each do |category|
    car = Car.create!(
      user_id: owner.id,
      brand: Faker::Vehicle.make,
      model: Faker::Vehicle.model,
      year: Faker::Vehicle.year,
      km: Faker::Vehicle.kilometrage,
      daily_rate: rand(400..2000),
      city: Faker::Address.full_address,
      category: category
    )

    photo_ini = rand(0..7)
    for photo in (1..3).to_a
      file_name = "#{car.category.downcase}#{photo_ini + photo}.jpg"
      file_path = "app/assets/images/seed-#{car.category.downcase}/#{file_name}"
      car.photos.attach(io: File.open(Rails.root + file_path),
                      filename: file_name,
                      content_type: 'image/jpg')
    end

    puts "CREATED CAR_ID: #{car.id} - #{car.year} #{car.brand} #{car.model}
          FOR OWNER_ID: #{car.user.id} - #{car.user.email} (pw:123456)
          WITH #{car.photos.count} PHOTOS IN #{car.category}"
  end
end
puts " "
puts " "

# ------------------------------------------------------------------------------
puts "(2) Creating a user with 5 rentals of owner's cars"
puts " "

user = User.create!(
  first_name: "UserNome",
  last_name: "UserSobrenome",
  phone: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.full_address,
  email: "user@teste.com",
  password: '123456',
  password_confirmation: '123456'
)
puts "CREATED USER_ID: #{user.id} - #{user.email} (pw:123456) AS #{user.first_name} ADDRESS #{user.address}"
puts " "

5.times do
  rental_car = Car.find(Car.all.ids.sample)
  rental = Rental.create!(
    user_id: user.id,
    car_id: rental_car.id,
    start_date: Date.today,
    finish_date: Faker::Date.between(from: Date.today, to: '2100-01-01')
  )
  puts "CREATED RENTAL_ID: #{rental.id} FROM #{rental.start_date} TO #{rental.finish_date}
        RENTAL OF CAR_ID: #{rental.car.id} - #{rental.car.year} #{rental.car.brand} <=> OWNER_ID: #{rental.car.user.id} OWNER EMAIL: #{rental.car.user.email}
        RENTAL FOR USER_ID: #{rental.user.id} - #{rental.user.email} (pw:123456) "
  puts " "
end
puts " "
puts " "

# ------------------------------------------------------------------------------
puts "(3) Creating an admin user account"
puts " "

admin = User.create!(
  first_name: "AdminNome",
  last_name: "AdminSobrenome",
  phone: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.full_address,
  admin: true, # <<<<<<<<<<<<<<<<<<<<<<<< THIS MAKES AN ADMIN ACCOUNT
  email: "admin@teste.com",
  password: '123456',
  password_confirmation: '123456'
)
puts "CREATED #{admin.email} (pw:123456) USER_ID: #{admin.id} AS #{admin.first_name} ADDRESS #{admin.address}"
puts "NOTE: ACCOUNT FLAGGED AS ADMIN: #{admin.admin}"
puts " "
puts "FINISHED SEEDING WITH PHOTOS!"
puts " "

# ------------------------------------------------------------------------------
puts "Created #{User.count} users"
puts "Created #{Car.count} cars"
puts "Created #{Rental.count} rentals"

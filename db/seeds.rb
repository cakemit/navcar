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
puts "(1) Creating 4 owners with 4 cars each"
puts " "

addresses = [
  "Rua Jardim Botânico 414, Rio de Janeiro, Rio de Janeiro, Brasil",
  "Avenida Presidente Vargas, Rio de Janeiro, Rio de Janeiro, Brasil",
  "Avenida Ipiranga 200, São Paulo, São Paulo, Brasil",
  "Rua dos Aflitos 70, São Paulo, São Paulo, Brasil"
]

addresses.each_with_index do |address, index|
  owner = User.create!(
    first_name: "Owner #{index}",
    last_name: "Schrubbles #{index}",
    phone: Faker::PhoneNumber.cell_phone,
    address: address,
    email: "owner#{index}@teste.com",
    password: '123456',
    password_confirmation: '123456'
  )
  puts "CREATED USER_ID: #{owner.id} - #{owner.email} (pw:123456) AS #{owner.first_name} ADDRESS #{owner.address}"
  puts " "

  # Create 1 car with photos in each category
  categories = ["Vintage", "Luxury", "Off-road", "Sport"]
  categories.each do |category|
    car = Car.create!(
      user_id: owner.id,
      brand: Faker::Vehicle.make,
      model: Faker::Vehicle.model,
      year: Faker::Vehicle.year,
      km: Faker::Vehicle.kilometrage,
      daily_rate: rand(400..2000),
      category: category
    )

    photo_ini = rand(0..7)
    (1..3).to_a.each do |photo|
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
  first_name: "User",
  last_name: "Shrubbles",
  phone: Faker::PhoneNumber.cell_phone,
  address: "Rua Colômbia, 3894 - Jardim Paulista, São Paulo - SP",
  email: "user@teste.com",
  password: '123456',
  password_confirmation: '123456'
)
puts "CREATED USER_ID: #{user.id} - #{user.email} (pw:123456) AS #{user.first_name} ADDRESS #{user.address}"
puts " "

5.times do
  rental_car = Car.find(Car.all.ids.sample)
  start_date = Faker::Date.between(from: Date.today, to: '2021-02-01')
  finish_date = start_date + (1..5).to_a.sample.days
  amount = rental_car.daily_rate * (finish_date - start_date)
  rental = Rental.create!(
    user_id: user.id,
    car_id: rental_car.id,
    start_date: start_date,
    finish_date: finish_date,
    amount: amount
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
  first_name: "Equipe",
  last_name: "Navcar",
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

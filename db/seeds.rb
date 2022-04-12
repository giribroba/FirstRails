User.delete_all

7.times do |i|
  User.create!(name: Faker::Games::ElderScrolls.name, age: rand(15..50))
end
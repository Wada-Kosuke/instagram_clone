User.create!(full_name: "Example Fullname",
             user_name: "Example Username",
             email: "user@example.com",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

30.times do |n|
  full_name  = Faker::Name.name
  user_name = Faker::Name.name
  email = "user-#{n+1}@example.com"
  password = "password"
  User.create!(full_name: full_name,
               user_name: user_name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

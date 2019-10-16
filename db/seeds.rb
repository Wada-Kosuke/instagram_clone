# ユーザー
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

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..30]
followers = users[3..20]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

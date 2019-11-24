# ユーザー
User.create!(full_name: "Example Fullname",
             user_name: "Example Username",
             email: "user@example.com",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             user_image: File.open("./app/assets/images/user1.jpg"))

20.times do |n|
  full_name  = Faker::Name.name
  user_name = Faker::Name.name
  email = "user-#{n+2}@example.com"
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

4.times do |n|
  content = Faker::Lorem.sentence(5)
  User.first.microposts.create!(
    picture: File.open("./app/assets/images/pic#{n+1}.jpg"),
    content: content,
    created_at: Time.zone.now.prev_day(n)
    )
end

2.times do |n|
  content = Faker::Lorem.sentence(5)
  User.find(n+2).microposts.create!(
    picture: File.open("./app/assets/images/pic#{n+5}.jpg"),
    content: content,
    created_at: Time.zone.now.prev_day(n+1)
    )
end

# コメント、いいね
users = User.order(:created_at).take(3)

users.each { |user|
  microposts = Micropost.all
  microposts.each do |micropost|
    content = Faker::Lorem.sentence(5)
    comment = user.comments.build(content: content)
    comment.micropost = micropost
    comment.save
  end
}

# いいね
users = User.where(id: 2..4)

users.each { |user|
  exampleuser_microposts = User.first.microposts
  exampleuser_microposts.each do |micropost|
    user.like(micropost)
  end
}
other_microposts = Micropost.where.not(user_id: User.first.id)
other_microposts.each do |micropost|
  User.first.like(micropost)
end

# リレーションシップ
users = User.all
user  = users.first
following = users[1..20]
followers = users[2..20]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

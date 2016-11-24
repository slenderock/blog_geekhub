# frozen_string_literal: true

Post.delete_all
User.delete_all

ActiveRecord::Base.connection.execute('TRUNCATE TABLE users RESTART IDENTITY')
ActiveRecord::Base.connection.execute('TRUNCATE TABLE posts RESTART IDENTITY')

30.times do |i|
  User.create(
    email: "user#{i}@ukr.net",
    password: '111111',
    password_confirmation:'111111'
  )
end

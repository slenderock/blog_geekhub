# frozen_string_literal: true

ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

50.times do |i|
  User.create(
    email: "user#{i}@ukr.net",
    password: '111111'
  )
end

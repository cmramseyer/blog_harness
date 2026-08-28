%w[admin@blog.com user@blog.com].each do |email|
  User.find_or_initialize_by(email:).update!(password: "blog1234")
end

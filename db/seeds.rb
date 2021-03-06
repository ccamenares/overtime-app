# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.create(email: "test@test.com", 
										password: "password", 
										password_confirmation: "password", 
										first_name: "Jon", 
										last_name: "Snow",
										phone: "4322386131",
										ssn: 1234,
										company: "ABC Company")

@admin_user = AdminUser.create(email: "admin@admin.com", 
															 password: "password", 
															 password_confirmation: "password", 
															 first_name: "Admin", 
															 last_name: "Admin",
															 phone: "4322386131",
															 ssn: 1234,
															 company: "ABC Company")


100.times do |post|
	Post.create!(date: Date.today, work_performed: "#{post} Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", user_id: @user.id, daily_hours: 8.5)
end

	AuditLog.create!(user_id: @user.id, status: 0, start_date: (Date.today - 6.days))
	AuditLog.create!(user_id: @user.id, status: 0, start_date: (Date.today - 13.days))
	AuditLog.create!(user_id: @user.id, status: 0, start_date: (Date.today - 20.days))

puts "1 user has been created"
puts "1 admin user has been created"
puts "100 posts have been created"
puts "3 audit logs have been created"
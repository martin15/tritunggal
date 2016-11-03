# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

about_us = SystemSetting.find_or_create_by(:name => "About Us")
puts about_us.inspect

user  = User.find_by_email("martin.me15@yahoo.com")
if user.nil?
  user_type_5 = User.create( :email => 'martin.me15@yahoo.com', :password => "12345678",
                             :password_confirmation => "12345678",
                             :first_name => "Martin", :last_name => "Martin",
                             :confirmed_at => Time.now)
end

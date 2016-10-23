# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_datas = [
  {email: 'suzukisho@nogista.com', unique_name: 'suzukisho', name: '鈴木翔'},
  {email: 'muraikenta@nogista.com', unique_name: 'muraikenta', name: '村井謙太'},
  {email: 'nishinonanase@nogista.com', unique_name: 'nishinonanase', name: 'ななせまる'},
  {email: 'hashimotonanami@nogista.com', unique_name: 'hashimotonanami', name: 'ななみん'},
  {email: 'ikutaerika@nogista.com', unique_name: 'ikutaerika', name: 'いくちゃん'},
]
users = []
user_datas.each do |user_data|
  user = User.find_or_create_by!(email: user_data[:email], unique_name: user_data[:unique_name]) do |user|
    user.name = user_data[:name]
    user.password = 'password'
  end
  users.push(user)
end

users.permutation(2).each do |user_pair|
  user_pair[0].follows_from_me.create(to_user: user_pair[1])
end

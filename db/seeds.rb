# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_datas = [
  {email: 'suzukisho@nogista.com', unique_name: 'suzukisho', name: '鈴木翔', image_url: 'https://pbs.twimg.com/profile_images/519171830767050752/IJcrUr4g.jpeg'},
  {email: 'muraikenta@nogista.com', unique_name: 'muraikenta', name: '村井謙太', image_url: 'https://pbs.twimg.com/profile_images/519171830767050752/IJcrUr4g.jpeg'},
  {email: 'nishinonanase@nogista.com', unique_name: 'nishinonanase', name: 'ななせまる', image_url: 'http://0117893.lolipop.jp/wallpaper/2015/AKB48/01171920_AKB48_78.jpg'},
  {email: 'hashimotonanami@nogista.com', unique_name: 'hashimotonanami', name: 'ななみん', image_url: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRcytWSbgKzjbE_AVukjD20O-stBwX3xVI98wTEkkzHKS_tOZyjdQ'},
  {email: 'ikutaerika@nogista.com', unique_name: 'ikutaerika', name: 'いくちゃん', image_url: 'http://sakura-ch24.com/wp-content/uploads/2016/01/f7b74a1da5a18640677529c754c0bbba.jpg'},
]
users = []
user_datas.each do |user_data|
  user = User.find_or_create_by!(email: user_data[:email], unique_name: user_data[:unique_name]) do |user|
    user_data.each do |key, value|
      user[key] = value
    end
    user.password = 'password'
  end
  users.push(user)
end

users.permutation(2).each do |user_pair|
  user_pair[0].follows_from_me.create(to_user: user_pair[1])
end

s3_path = 'https://s3-ap-northeast-1.amazonaws.com/nogistagram/post_images/'
post_datas = [
  {user_unique_name: 'hashimotonanami', body: '卒業します...'},
  {user_unique_name: 'ikutaerika', body: 'お腹すいた！！！'},
  {user_unique_name: 'nishinonanase', body: 'ん〜、ななせまる！'},
]
post_datas.each do |post_data|
  user = User.find_by(unique_name: post_data[:user_unique_name])
  user.posts.find_or_create_by!(image_url: "#{s3_path}#{user.unique_name}.jpg") do |post|
    post.body = post_data[:body]
  end
end

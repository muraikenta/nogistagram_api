# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string
#  unique_name  :string
#  email        :string
#  introduction :text
#  website      :string
#  gender       :integer
#  image_url    :string
#  privacy_type :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class User < ActiveRecord::Base
  # validations
  # TODO: DB側もuniqueに
  validates :unique_name, presence: true, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, presence: true, uniqueness: true
end

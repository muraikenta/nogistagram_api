# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  image_url  :string
#  body       :text
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  # associations
  belongs_to :user

  # validations
  validates :image_url, presence: true, uniqueness: true
end

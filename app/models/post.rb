# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  image_url  :string
#  body       :text
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
end

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

  def set_image(binary)
    file_name = Time.zone.now.to_i.to_s + rand(1000000).to_s + ".png"
    File.open("public/post_images/#{file_name}", 'wb') { |f| f.write(binary) }
    self.image_url =  "http://localhost:3002/post_images/#{file_name}"
  end
end

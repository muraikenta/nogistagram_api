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
  has_many :likes, dependent: :destroy

  # validations
  validates :image_url, presence: true, uniqueness: true

  def set_image(binary)
    file_name = Time.zone.now.to_i.to_s + rand(1_000_000).to_s + '.png'
    File.open("public/post_images/#{file_name}", 'wb') { |f| f.write(binary) }
    self.image_url = "http://localhost:3002/post_images/#{file_name}"
  end

  def to_builder(opts = {})
    user = opts[:user]
    Jbuilder.new do |post|
      post.call(self, :id, :user_id, :image_url, :body, :created_at)
      post.user self.user
      post.is_liked self.liked_from?(user)
    end
  end

  def liked_from?(user)
    self.likes.find_by(user: user).present?
  end
end

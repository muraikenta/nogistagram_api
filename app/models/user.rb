# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  unique_name            :string
#  email                  :string
#  introduction           :text
#  website                :string
#  gender                 :integer
#  image_url              :string
#  privacy_type           :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  tokens                 :text
#  omniauth_token         :string
#

class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable

  include DeviseTokenAuth::Concerns::User

  # MARK: associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :follows_from_me, class_name: 'Follow', foreign_key: :from_user_id, dependent: :destroy
  has_many :follows_from_others, class_name: 'Follow', foreign_key: :to_user_id, dependent: :destroy
  has_many :following_users, class_name: 'User', through: :follows_from_me, source: :to_user
  has_many :followed_users, class_name: 'User', through: :follows_from_others, source: :from_user

  # MARK: validations
  # TODO: DB側もuniqueに
  validates :unique_name, presence: true, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, presence: true, uniqueness: true

  # MARK: instance methods
  def set_data_for_facebook
    self.image_url = "https://graph.facebook.com/#{self.uid}/picture?type=large"
    self.password = Devise.friendly_token[0, 20]
  end

  def timeline_posts
    Post.where(user: [self, self.following_users])
  end

  # MARK: class methods
  def self.search(text)
    return [] if text.blank?
    return User.where('unique_name LIKE ? OR name LIKE ?', "%#{text}%", "%#{text}%")
  end
end

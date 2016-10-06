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
#

class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable

  include DeviseTokenAuth::Concerns::User
  # validations
  # TODO: DB側もuniqueに
  validates :unique_name, presence: true, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, presence: true, uniqueness: true

  before_validation :set_dummy_unique_name

  private

  def set_dummy_unique_name
    self.unique_name = Time.zone.now.to_s + self.email
  end
end

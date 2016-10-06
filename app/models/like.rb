# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ActiveRecord::Base
  # associations
  belongs_to :user
  belongs_to :post

  # validations
  validates :user_id, presence: true, uniqueness: { scope: [:post_id] }
  validates :post_id, presence: true
end

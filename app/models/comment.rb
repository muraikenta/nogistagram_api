# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_id    :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  # associations
  belongs_to :user
  belongs_to :post

  # validations
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :body, presence: true
end

# == Schema Information
#
# Table name: follows
#
#  id           :integer          not null, primary key
#  from_user_id :integer
#  to_user_id   :integer
#  state        :integer          default(1)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Follow < ActiveRecord::Base
  # associations
  belongs_to :from_user, class_name: 'User', foreign_key: :from_user_id
  belongs_to :to_user, class_name: 'User', foreign_key: :to_user_id

  # validations
  validates :from_user_id, presence: true, uniqueness: { scope: [:to_user_id] }
  validates :to_user_id, presence: true
end

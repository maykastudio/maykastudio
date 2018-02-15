class Permission < ApplicationRecord
  belongs_to :user

  extend Enumerize
  enumerize :role, in: [:administrator], predicates: true
end

# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  role       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

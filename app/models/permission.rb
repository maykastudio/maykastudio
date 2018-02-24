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
# Indexes
#
#  index_permissions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

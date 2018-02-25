# == Schema Information
#
# Table name: views
#
#  id            :integer          not null, primary key
#  session       :text
#  user_agent    :text
#  viewable_type :string
#  viewable_id   :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_views_on_user_id                        (user_id)
#  index_views_on_viewable_type_and_viewable_id  (viewable_type,viewable_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class View < ApplicationRecord
  belongs_to :viewable, polymorphic: true
  belongs_to :user, optional: true

  validates_presence_of :session, :user_agent
  validates_uniqueness_of :session, scope: [:viewable_id, :viewable_type]
end

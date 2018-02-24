class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_many :permissions, dependent: :destroy
  has_many :projects, -> { order('created_at desc') }, dependent: :destroy

  validates_presence_of :email

  def administrator?
    permissions.where(role: :administrator).any?
  end

  def remember_me
    true
  end
end

# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :inet
#  last_sign_in_ip     :inet
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class Project < ApplicationRecord
  belongs_to :user

  validates_presence_of :title

  before_create :generate_secret_codes

  private

  def generate_secret_codes
    self.preview_code = loop do
      random_code = SecureRandom.hex(3)
      break random_code unless Project.exists?(preview_code: random_code)
    end

    self.view_code = loop do
      random_code = SecureRandom.hex(3)
      break random_code unless Project.exists?(view_code: random_code)
    end
  end
end

# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  title          :string
#  preview_code   :string
#  view_code      :string
#  published      :boolean          default(TRUE)
#  download_count :integer          default(0)
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

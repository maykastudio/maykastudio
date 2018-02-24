class Project < ApplicationRecord
  belongs_to :user

  has_many :images, -> { order(:position) }, dependent: :destroy
  has_one :image, -> { order('created_at asc') }, class_name: 'Image'

  validates_presence_of :title, :download_count

  before_create :generate_secret_codes
  after_commit :update_images_position

  scope :published, ->{ where(published: true) }

  def to_json
    {
      code: code,
      title: title,
      download_count: download_count - images.selected.count,
      selected: images.selected.ids,
      images: images.map{ |i| i.to_json }
    }
  end

  def select_images(imgs)
    imgs.take(self.download_count).each do |image_id|
      image = images.find(image_id)

      if image
        image.update_attributes(selected: true)
      end
    end
  end

  private

  def generate_secret_codes
    self.code = loop do
      random_code = SecureRandom.hex(3)
      break random_code unless Project.exists?(code: random_code)
    end
  end

  def update_images_position
    images.each_with_index{ |image, index| image.update_columns(position: index + 1) }
  end
end

# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  title          :string
#  code           :string
#  published      :boolean          default(TRUE)
#  download_count :integer          default(0)
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

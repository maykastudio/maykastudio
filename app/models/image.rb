class Image < ApplicationRecord
  belongs_to :project, touch: true

  mount_uploader :file, ImageUploader

  validates_presence_of :file
  validates_uniqueness_of :position, scope: :project_id

  scope :selected, ->{ where(selected: true) }

  def to_json
    {
      id: id,
      position: position,
      url: file.thumbnail.url,
      preview: file.preview.url,
      download: download_url,
      selected: selected
    }
  end

  private

  def download_url
    selected? ? file.url : nil
  end
end

# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  file       :text
#  position   :integer
#  selected   :boolean          default(FALSE)
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

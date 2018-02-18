class Image < ApplicationRecord
  belongs_to :project, touch: true

  mount_uploader :file, ImageUploader

  validates_presence_of :file
  validates_uniqueness_of :position, scope: :project_id
end

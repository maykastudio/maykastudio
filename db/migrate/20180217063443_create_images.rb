class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.text :file
      t.string :content_type
      t.integer :file_size
      t.integer :position
      t.boolean :selected, default: false
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end

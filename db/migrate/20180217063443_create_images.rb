class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.text :file
      t.integer :position
      t.boolean :selected, default: false
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end

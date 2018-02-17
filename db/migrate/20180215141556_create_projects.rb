class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :code
      t.boolean :published, default: true
      t.integer :download_count, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

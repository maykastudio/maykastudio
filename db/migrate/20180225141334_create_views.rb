class CreateViews < ActiveRecord::Migration[5.1]
  def change
    create_table :views do |t|
      t.text :session
      t.text :user_agent
      t.references :viewable, index: true, polymorphic: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

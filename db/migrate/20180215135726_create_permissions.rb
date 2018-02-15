class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.string :role
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

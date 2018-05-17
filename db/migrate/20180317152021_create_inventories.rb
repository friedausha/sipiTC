class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.references :laboratory, null: false, foreign_key: true
      t.string :spec, null: false
      t.string :note
      t.string :name, null: false
      t.date :reservation_started
      t.date :reservation_ended
      t.integer :status, null: false
      t.timestamps
    end
  end
end

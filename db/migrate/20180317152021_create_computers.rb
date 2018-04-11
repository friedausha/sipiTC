class CreateComputers < ActiveRecord::Migration[5.0]
  def change
    create_table :computers do |t|
      t.references :laboratory, null: false, foreign_key: true
      t.string :spec, null: false
      t.string :note
      t.string :name, null: false
      t.datetime :reservation_started
      t.datetime :reservation_ended
      t.integer :status, null: false
      t.timestamps
    end
  end
end

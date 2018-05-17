class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.integer :user_id, null: false
      t.integer :inventory_id, null: false
      t.string :reason, null: false
      t.integer :status, null: false, default: 0
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.timestamps
    end
    add_foreign_key :reservations, :inventories, column: :inventory_id
    add_index :reservations, :inventory_id
    add_foreign_key :reservations, :users, column: :user_id
    add_index :reservations, :user_id
  end
end

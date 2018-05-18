class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :nrp, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :phone_number, null: false
      t.string :password, null: false
      t.timestamps
    end
  end
end

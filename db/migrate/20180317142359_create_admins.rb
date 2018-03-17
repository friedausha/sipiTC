class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.references :laboratory, null: false, foreign_key: true
      t.string :name, null: false
      t.string :nrp, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :phone_number, null: false
      t.timestamps
    end
  end
end

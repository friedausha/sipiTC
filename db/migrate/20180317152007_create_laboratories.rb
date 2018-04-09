class CreateLaboratories < ActiveRecord::Migration[5.0]
  def change
    create_table :laboratories do |t|
      t.string :name, unique: true, null: false
      t.string :email, unique: true, null: false
      t.string :password, null: false
      t.timestamps
    end
  end
end

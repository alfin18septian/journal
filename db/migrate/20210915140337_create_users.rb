class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :username, null: false, unique: true
      t.string :password_digest
      t.string :email, null: false, unique: true
      t.string :phone, null: false, unique: true
      t.string :role, null: false
      t.datetime :last_login

      t.timestamps
    end
  end
end

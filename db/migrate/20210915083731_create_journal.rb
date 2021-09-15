class CreateJournal < ActiveRecord::Migration[6.1]
  def change
    create_table :journals do |t|
      t.string :category
      t.string :tag
      t.text :abstract
      t.string :full_text
      t.string :publisher
      t.string :verified_by
      t.datetime :verified_at
      
      t.timestamps
    end
  end
end

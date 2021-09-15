class AddCategoryToTag < ActiveRecord::Migration[6.1]
  def change
    add_reference :tags, :category
  end
end

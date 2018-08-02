class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
    	t.string :name
    	t.string :author
    	t.integer :isbn
    	t.integer :price
    	t.string :category
    	t.string :status
    end
  end
end


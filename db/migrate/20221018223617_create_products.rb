class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :price
      t.string :category
      t.float :weight
      t.float :volume

      t.timestamps
    end
  end
end

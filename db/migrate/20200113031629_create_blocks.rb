class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.string :name
      t.string :block_type
      t.integer :order
      t.integer :duration

      t.timestamps
    end
  end
end

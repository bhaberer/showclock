class AddDayIdToBlocks < ActiveRecord::Migration[5.2]
  def change
    add_column :blocks, :day_id, :integer
  end
end

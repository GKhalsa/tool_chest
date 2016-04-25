class AddNumberToTool < ActiveRecord::Migration
  def change
    add_column :tools, :number, :string
  end
end

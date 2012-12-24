class AddReturnCodeToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :return_code, :string, :null => false, :limit => 10
    add_index :places, :return_code, :unique => true
  end
end

class AddTitleToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :title, :string, :limit => 50
  end
end

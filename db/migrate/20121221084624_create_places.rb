class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string  :name,         :null => false, :limit => 30
      t.string  :slug,         :null => false, :limit => 10
      t.string  :description,  :limit => 200
      t.integer :frames_count, :default => 0
      t.timestamps
    end
    
    add_index :places, :name, :unique => true
    add_index :places, :slug, :unique => true
  end
end

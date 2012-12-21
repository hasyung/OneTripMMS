class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.references :place,     :null => false
      t.integer    :number,    :null => false, :default => 0
      t.text       :body,      :null => false
      t.text       :content,   :null => false

      t.timestamps
    end
    
    add_index :frames, [:place_id, :number], :unique => true
  end
end
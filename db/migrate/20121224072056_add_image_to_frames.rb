class AddImageToFrames < ActiveRecord::Migration
  def change
    add_column :frames, :image, :string, :null => false
    add_column :frames, :image_base64, :text, :null => false
    add_column :frames, :image_content_type, :string
    add_column :frames, :image_size, :integer, :default => 0
    add_column :frames, :image_ext, :string
  end
end

class AddCaptionToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :caption, :string, default: ''
  end
end

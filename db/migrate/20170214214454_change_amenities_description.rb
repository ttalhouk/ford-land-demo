class ChangeAmenitiesDescription < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :amenities do |t|
        dir.up   { t.change :description, :text }
        dir.down { t.change :description, :string }
      end
    end
  end
end

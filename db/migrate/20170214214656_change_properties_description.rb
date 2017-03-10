class ChangePropertiesDescription < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :properties do |t|
        dir.up   { t.change :description, :text }
        dir.down { t.change :description, :string }
      end
    end
  end
end

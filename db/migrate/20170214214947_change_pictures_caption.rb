class ChangePicturesCaption < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :pictures do |t|
        dir.up   { t.change :caption, :text }
        dir.down { t.change :caption, :string }
      end
    end
  end
end

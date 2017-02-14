class ChangeServicesDetails < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :services do |t|
        dir.up   { t.change :details, :text }
        dir.down { t.change :details, :string }
      end
    end
  end
end

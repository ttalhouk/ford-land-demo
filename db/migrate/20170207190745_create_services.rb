class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.boolean :open, default: :true
      t.integer :user_id
      t.string :details

      t.timestamps
    end
  end
end

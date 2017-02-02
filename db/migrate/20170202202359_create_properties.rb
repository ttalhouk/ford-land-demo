class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :name , null: false
      t.string :description, null: false
      t.boolean :available, default: true

      t.timestamps
    end
  end
end

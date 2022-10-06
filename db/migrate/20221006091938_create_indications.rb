class CreateIndications < ActiveRecord::Migration[7.0]
  def change
    create_table :indications do |t|
      t.float :temperature
      t.string :unit
      t.integer :epochTime

      t.timestamps
    end
  end
end

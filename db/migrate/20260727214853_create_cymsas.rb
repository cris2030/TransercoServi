class CreateCymsas < ActiveRecord::Migration[7.2]
  def change
    create_table :cymsas do |t|
      t.string :gps_id
      t.string :nombre
      t.string :matricula
      t.decimal :odometro

      t.timestamps
    end
  end
end

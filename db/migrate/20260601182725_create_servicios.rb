class CreateServicios < ActiveRecord::Migration[7.2]
  def change
    create_table :servicios do |t|
      t.references :unidad, null: false, foreign_key: true
      t.integer :kilometraje
      t.date :fecha
      t.string :nom_mecanico

      t.timestamps
    end
  end
end

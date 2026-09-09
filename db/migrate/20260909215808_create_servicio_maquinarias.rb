class CreateServicioMaquinarias < ActiveRecord::Migration[7.2]
  def change
    create_table :servicio_maquinarias do |t|
      t.references :maquinaria, null: false, foreign_key: true
      t.date :fecha
      t.time :hora

      t.timestamps
    end
  end
end

class CreateAsignacionMetas < ActiveRecord::Migration[7.2]
  def change
    create_table :asignacion_metas do |t|
      t.references :unidad, null: false, foreign_key: true
      t.references :meta, null: false, foreign_key: true

      t.timestamps
    end
  end
end

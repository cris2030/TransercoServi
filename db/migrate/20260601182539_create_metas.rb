class CreateMetas < ActiveRecord::Migration[7.2]
  def change
    create_table :metas do |t|
      t.string :nombre
      t.integer :kilometraje_inicio
      t.integer :kilometraje_final
      t.string :color
      t.integer :nivel_imp

      t.timestamps
    end
  end
end

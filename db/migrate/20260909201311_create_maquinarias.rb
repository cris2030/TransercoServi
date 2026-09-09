class CreateMaquinarias < ActiveRecord::Migration[7.2]
  def change
    create_table :maquinarias do |t|
      t.string :nombre
      t.string :codigo
      t.string :numero_serie

      t.timestamps
    end
  end
end

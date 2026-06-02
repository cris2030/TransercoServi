class CreateUnidades < ActiveRecord::Migration[7.2]
  def change
    create_table :unidades do |t|
      t.string :unitID
      t.string :codigo
      t.string :placa

      t.timestamps
    end
    add_index :unidades, :unitID
  end
end

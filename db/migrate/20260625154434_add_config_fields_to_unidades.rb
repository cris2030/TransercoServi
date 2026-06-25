class AddConfigFieldsToUnidades < ActiveRecord::Migration[7.2]
  def change
    add_column :unidades,
               :mostrar_motor_hours,
               :boolean,
               default: false,
               null: false

    add_column :unidades,
               :usar_odometro_ecm,
               :boolean,
               default: false,
               null: false
  end
end
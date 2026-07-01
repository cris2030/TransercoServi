class AddMotorHoursToMetas < ActiveRecord::Migration[7.2]
  def change
    add_column :metas, :cantidad_meta_horas, :integer
    add_column :metas, :alerta_horas, :integer
    add_column :metas, :urgente_horas, :integer
  end
end

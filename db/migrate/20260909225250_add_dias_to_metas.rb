class AddDiasToMetas < ActiveRecord::Migration[7.2]
  def change
    add_column :metas, :cantidad_meta_dias, :integer
    add_column :metas, :alerta_dias, :integer
    add_column :metas, :urgente_dias, :integer
  end
end

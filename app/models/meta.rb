class Meta < ApplicationRecord

  has_many :asignacion_metas,
           dependent: :destroy

  has_many :unidades,
           through: :asignacion_metas

  def to_s
    nombre
  end
end
class Unidad < ApplicationRecord

  has_many :servicios, dependent: :destroy

  has_many :asignacion_metas,
           dependent: :destroy

  has_many :metas,
           through: :asignacion_metas
           
  def to_s
    codigo
  end

  def ultimo_servicio
    servicios.order(fecha: :desc).first
  end

end
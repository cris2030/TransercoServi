class Maquinaria < ApplicationRecord

  has_many :asignacion_maquinaria_metas,
           dependent: :destroy

  has_many :metas,
           through: :asignacion_maquinaria_metas

  validates :nombre, presence: true
  validates :codigo, presence: true, uniqueness: true
  validates :numero_serie, presence: true, uniqueness: true

  has_many :servicio_maquinarias,
         dependent: :destroy


  def to_s
    codigo
  end

end

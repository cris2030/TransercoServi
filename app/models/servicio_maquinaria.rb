class ServicioMaquinaria < ApplicationRecord

  belongs_to :maquinaria

  validates :maquinaria, presence: true
  validates :fecha, presence: true
  validates :hora, presence: true

end

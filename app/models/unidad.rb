class Unidad < ApplicationRecord


  has_many :servicios, dependent: :destroy

  has_many :asignacion_metas,
           dependent: :destroy

  has_many :metas,
           through: :asignacion_metas

  validates :unitID, presence: true, uniqueness: true
  validates :codigo, presence: true, uniqueness: true
  validates :placa,  presence: true, uniqueness: true

  has_one :ultimo_servicio,
        -> { order(fecha: :desc) },
        class_name: "Servicio"
           
  def to_s
    codigo
  end

  def self.sync_from_linker_api(api)
    response = api.current_odometers

    return false unless response[:Result] == "OK"

    units = response[:OdometersInfo] || []

    units.each do |item|
      next if item[:UnitID].blank?

      Unidad.find_or_create_by!(unitID: item[:UnitID].to_s) do |u|
        u.codigo = item[:UnitName]
        u.placa  = item[:Plates]
      end
    end

    true
  end
  

end
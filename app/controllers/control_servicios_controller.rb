class ControlServiciosController < ApplicationController

  def index
    cargar_dashboard
  end

  def actualizar
    cargar_dashboard

    render :index
  end

  private

  def cargar_dashboard

    api = LinkerApi.new

    odometros = api.odometros_por_unidad

    @control_servicios =
      Unidad
      .includes(:metas, :servicios)
      .map do |unidad|

        ultimo_servicio =
          unidad.servicios
                .order(fecha: :desc)
                .first

        km_servicio =
          ultimo_servicio&.kilometraje.to_i

        odometro_actual =
          odometros[unidad.unitID.to_s].to_i

        km_desde_servicio =
          odometro_actual - km_servicio

        metas_en_rango =
          unidad.metas
                .where(
                  "? BETWEEN kilometraje_inicio AND kilometraje_final",
                  km_desde_servicio
                )

        meta_actual =
          metas_en_rango.order(:nivel_imp).first ||
          unidad.metas.order(:nivel_imp).first
          
        
      {
        unidad: unidad,
        placa: unidad.placa,
        fecha_ultimo_servicio: ultimo_servicio&.fecha,
        km_desde_servicio: km_desde_servicio,
        meta_actual: meta_actual
      }
      end
      

    @control_servicios = @control_servicios.sort_by do |fila|
      [
        fila[:meta_actual]&.nivel_imp || 999,
        -fila[:km_desde_servicio]
      ]
    end

  end

end
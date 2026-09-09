class ControlServicioMaquinariasController < ApplicationController

  def index
    cargar_dashboard
  end

  def actualizar
    cargar_dashboard
    render :index
  end

  private

  def cargar_dashboard

    @control_servicio_maquinarias =
      Maquinaria
        .includes(
          :servicio_maquinarias,
          :metas
        )
        .map do |maquinaria|


      # ==========================================
      # ÚLTIMO SERVICIO
      # ==========================================

      ultimo_servicio =
        maquinaria.servicio_maquinarias
                  .order(
                    fecha: :desc,
                    hora: :desc
                  )
                  .first


      fecha_ultimo_servicio =
        ultimo_servicio&.fecha

      hora_ultimo_servicio =
        ultimo_servicio&.hora


      # ==========================================
      # DÍAS TRANSCURRIDOS
      # ==========================================

      dias_recorridos =
        if fecha_ultimo_servicio.present?

          (
            Date.current -
            fecha_ultimo_servicio.to_date
          ).to_i

        else
          nil
        end


      # ==========================================
      # FORMATO
      # ==========================================

      dias_recorridos_formateados =
        if dias_recorridos.present?

          meses = dias_recorridos / 30
          dias  = dias_recorridos % 30

          "#{meses}m-#{dias}d"

        else

          "-"

        end


      # ==========================================
      # META DE DÍAS
      # ==========================================

      meta_actual =
        maquinaria.metas
                  .select { |meta|
                    meta.cantidad_meta_dias.present?
                  }
                  .min_by(&:cantidad_meta_dias)


      # ==========================================
      # ESTADO
      # ==========================================

      estado =
        if meta_actual.present? &&
           dias_recorridos.present?

          meta_actual.estado_dias(
            dias_recorridos
          )

        else

          nil

        end


      # ==========================================
      # DÍAS RESTANTES
      # ==========================================

      dias_restantes =
        if meta_actual.present? &&
           dias_recorridos.present?

          meta_actual.dias_restantes(
            dias_recorridos
          )

        else

          nil

        end


      # ==========================================
      # AVANCE
      # ==========================================

      avance_meta =
        if meta_actual.present? &&
           dias_recorridos.present?

          dias_recorridos -
            meta_actual.cantidad_meta_dias

        else

          -999_999

        end


      {
        maquinaria: maquinaria,

        ultimo_servicio: ultimo_servicio,

        fecha_ultimo_servicio:
          fecha_ultimo_servicio,

        hora_ultimo_servicio:
          hora_ultimo_servicio,

        dias_recorridos:
          dias_recorridos,

        dias_recorridos_formateados:
          dias_recorridos_formateados,

        meta_actual:
          meta_actual,

        estado:
          estado,

        dias_restantes:
          dias_restantes,

        avance_meta:
          avance_meta
      }

    end


    # ==========================================
    # ORDEN
    # ==========================================

    @control_servicio_maquinarias =
      @control_servicio_maquinarias.sort_by do |fila|

        prioridad =
          case fila[:estado]

          when :urgente
            0

          when :alerta
            1

          when :cumplido
            2

          else
            3

          end


        [
          prioridad,
          -fila[:avance_meta]
        ]

      end

  end

end

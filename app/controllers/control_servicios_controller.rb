class ControlServiciosController < ApplicationController

  def index
    cargar_dashboard
  end

  def actualizar
    cargar_dashboard
    render :index
  end

  def enviar_notificaciones

    cargar_dashboard

    registros_por_estado =
      @control_servicios.group_by { |fila| fila[:estado].to_s }

    %w[alerta cumplido urgente].each do |estado|

      registros = registros_por_estado[estado] || []

      next if registros.empty?

      destinatarios =
        MetaNotificacion
          .includes(:user)
          .where(estado: estado)
          .map { |n| n.user.email }
          .uniq

      next if destinatarios.empty?

      ReporteUrgenteMailer
        .reporte_diario(
          registros,
          destinatarios,
          estado
        )
        .deliver_now
    end

    head :ok
  end

  private

  def cargar_dashboard

    api = LinkerApi.new
    odometros = api.odometros_por_unidad

    @control_servicios =
      Unidad.includes(:ultimo_servicio, :metas).map do |unidad|

        ultimo_servicio = unidad.ultimo_servicio

        fecha_ultimo_servicio = ultimo_servicio&.fecha
        hora_ultimo_servicio  = ultimo_servicio&.hora

        dias_recorridos =
          if fecha_ultimo_servicio.present?
            total_dias = (Date.current - fecha_ultimo_servicio.to_date).to_i
            meses = total_dias / 30
            dias  = total_dias % 30
            "#{meses}m-#{dias}d"
          else
            "-"
          end

        km_servicio = ultimo_servicio&.kilometraje.to_i
        hm_servicio = ultimo_servicio&.motor_hours

        datos_unidad = odometros[unidad.unitID.to_s] || {}

        odometro_actual =
          if unidad.usar_odometro_ecm
            datos_unidad[:odometro_ecm].to_i
          else
            datos_unidad[:odometro_gps].to_i
          end

        motor_hours =
          if unidad.mostrar_motor_hours
            datos_unidad[:motor_hours].to_f
          end

        km_desde_servicio = odometro_actual - km_servicio

        hm_desde_servicio =
          if motor_hours.present? && hm_servicio.present?
            motor_hours - hm_servicio
          end

        meta_actual =
          if unidad.mostrar_motor_hours
            unidad.metas
                  .select { |m| m.cantidad_meta_horas.present? }
                  .min_by(&:cantidad_meta_horas)
          else
            unidad.metas
                  .select { |m| m.cantidad_meta.present? }
                  .min_by(&:cantidad_meta)
          end

        if unidad.mostrar_motor_hours

          estado = meta_actual&.estado_horas(hm_desde_servicio)

          restante = meta_actual&.horas_restantes(hm_desde_servicio)

          avance_meta =
            if meta_actual && hm_desde_servicio
              hm_desde_servicio - meta_actual.cantidad_meta_horas
            else
              -999_999
            end

        else

          estado = meta_actual&.estado(km_desde_servicio)

          restante = meta_actual&.km_restantes(km_desde_servicio)

          avance_meta =
            if meta_actual
              km_desde_servicio - meta_actual.cantidad_meta
            else
              -999_999
            end

        end

        {
          unidad: unidad,
          ultimo_servicio: ultimo_servicio,
          fecha_ultimo_servicio: fecha_ultimo_servicio,
          hora_ultimo_servicio: hora_ultimo_servicio,
          dias_recorridos: dias_recorridos,
          motor_hours: motor_hours,
          km_desde_servicio: km_desde_servicio,
          hm_desde_servicio: hm_desde_servicio,
          odometro_actual: odometro_actual,
          meta_actual: meta_actual,
          estado: estado,
          restante: restante,
          avance_meta: avance_meta
        }

      end

    @control_servicios =
      @control_servicios.sort_by do |fila|

        prioridad =
          case fila[:estado]
          when :urgente
            0
          when :cumplido
            1
          when :alerta
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
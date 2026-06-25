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
      @control_servicios.group_by do |fila|
        fila[:estado].to_s
      end

    %w[alerta cumplido urgente].each do |estado|

      registros =
        registros_por_estado[estado] || []

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
        Rails.logger.info "GMAIL_USERNAME presente: #{ENV['GMAIL_USERNAME'].present?}"
        Rails.logger.info "GMAIL_APP_PASSWORD presente: #{ENV['GMAIL_APP_PASSWORD'].present?}"
        .deliver_now
    end

    head :ok
  end

  private

  def cargar_dashboard

    api = LinkerApi.new

    odometros = api.odometros_por_unidad

    @control_servicios =
    Unidad.includes(:ultimo_servicio, :metas)
    .map do |unidad|

    ultimo_servicio = unidad.ultimo_servicio
      
    fecha_ultimo_servicio = ultimo_servicio&.fecha
    
    hora_ultimo_servicio =  ultimo_servicio&.hora

    dias_recorridos = if fecha_ultimo_servicio.present?

    total_dias = 
    (Date.current - fecha_ultimo_servicio.to_date).to_i
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
      else
        nil
      end

    km_desde_servicio =odometro_actual - km_servicio
    hm_desde_servicio =
    motor_hours.present? && hm_servicio.present? ?
      (motor_hours - hm_servicio) :
      nil

    meta_actual =
      unidad.metas.min_by do |meta|
        meta.cantidad_meta
      end
    estado = meta_actual&.estado(km_desde_servicio)

    km_restantes = meta_actual&.km_restantes(km_desde_servicio)
      
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
      km_restantes: km_restantes
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
            fila[:km_restantes] || 999999
          ]
        end

  end


end
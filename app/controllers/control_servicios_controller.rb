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
        .deliver_now
    end

    head :ok
  end

  private

  def cargar_dashboard

    api = LinkerApi.new

    odometros = api.odometros_por_unidad

    @control_servicios =
    Unidad
    .includes(:metas, :servicios)
    .map do |unidad|

    ultimo_servicio = unidad.servicios.max_by(&:fecha)
      
    fecha_ultimo_servicio = ultimo_servicio&.fecha

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

    odometro_actual = odometros[unidad.unitID.to_s].to_i

    km_desde_servicio =odometro_actual - km_servicio

    meta_actual =
      unidad.metas.min_by do |meta|
        meta.cantidad_meta
      end
    estado = meta_actual&.estado(km_desde_servicio)

    km_restantes = meta_actual&.km_restantes(km_desde_servicio)
      
      {
        unidad: unidad,
        fecha_ultimo_servicio: ultimo_servicio&.fecha,
        dias_recorridos: dias_recorridos,
        km_desde_servicio: km_desde_servicio,
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
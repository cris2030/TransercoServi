class ReporteUrgenteJob < ApplicationJob

  queue_as :default

  def perform

    registros =
      ReporteUrgenteService.generar

    registros = [] if registros.nil?

    ReporteUrgenteMailer
      .reporte_diario(registros)
      .deliver_now

  end

end
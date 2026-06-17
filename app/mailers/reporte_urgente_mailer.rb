class ReporteUrgenteMailer < ApplicationMailer

  default from: ENV["GMAIL_USERNAME"]

  def reporte_diario(registros, destinatarios, estado)

    @registros = registros
    @estado = estado

    mail(
      to: destinatarios,
      subject: "Reporte de unidades #{estado.upcase}"
    )
  end
end
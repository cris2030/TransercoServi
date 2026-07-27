class Api::CymsasController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def import
    datos = JSON.parse(request.body.read)

    registros = datos.map do |item|
      {
        gps_id: item["id"],
        nombre: item["nombre"],
        matricula: item["matricula"],
        odometro: item["odometro"],
        created_at: Time.current,
        updated_at: Time.current
      }
    end

    Cymsa.upsert_all(
      registros,
      unique_by: :index_cymsas_on_gps_id
    )

    render json: {
      mensaje: "Importación realizada correctamente",
      total: registros.size
    }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def upload
    archivo = params[:file]

    return render json: { error: "No se envió ningún archivo" }, status: :bad_request unless archivo

    datos = JSON.parse(archivo.read)

    registros = datos.map do |item|
      {
        gps_id: item["id"],
        nombre: item["nombre"],
        matricula: item["matricula"],
        odometro: item["odometro"],
        created_at: Time.current,
        updated_at: Time.current
      }
    end

    Cymsa.upsert_all(
      registros,
      unique_by: :index_cymsas_on_gps_id
    )

    render json: {
      mensaje: "Archivo importado correctamente",
      total: registros.size
    }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end

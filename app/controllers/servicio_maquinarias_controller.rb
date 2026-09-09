class ServicioMaquinariasController < ApplicationController
  before_action :set_servicio_maquinaria,
                only: %i[show edit update destroy]

  # GET /servicio_maquinarias
  def index
    @servicio_maquinarias =
      ServicioMaquinaria
        .includes(:maquinaria)
        .order(fecha: :desc, hora: :desc)
        .page(params[:page])
        .per(10)
  end

  # GET /servicio_maquinarias/1
  def show
  end

  # GET /servicio_maquinarias/new
  def new
    @servicio_maquinaria = ServicioMaquinaria.new(
      maquinaria_id: params[:maquinaria_id],
      fecha: Date.current,
      hora: Time.current
    )

    @return_to = params[:return_to]
  end

  # GET /servicio_maquinarias/1/edit
  def edit
    @return_to = params[:return_to]
  end

  # POST /servicio_maquinarias
  def create

    @servicio_maquinaria =
      ServicioMaquinaria.new(servicio_maquinaria_params)

    respond_to do |format|

      if @servicio_maquinaria.save

        destino =
          params[:return_to].presence ||
          servicio_maquinarias_path

        format.html do
          redirect_to destino,
                      notice: "Servicio de maquinaria creado correctamente."
        end

        format.json do
          render :show,
                 status: :created,
                 location: @servicio_maquinaria
        end

      else

        @return_to = params[:return_to]

        format.html do
          render :new,
                 status: :unprocessable_content
        end

        format.json do
          render json: @servicio_maquinaria.errors,
                 status: :unprocessable_content
        end

      end

    end
  end

  # PATCH/PUT /servicio_maquinarias/1
  def update

    respond_to do |format|

      if @servicio_maquinaria.update(
        servicio_maquinaria_params
      )

        destino =
          params[:return_to].presence ||
          @servicio_maquinaria

        format.html do
          redirect_to destino,
                      notice: "Servicio de maquinaria actualizado correctamente.",
                      status: :see_other
        end

        format.json do
          render :show,
                 status: :ok,
                 location: @servicio_maquinaria
        end

      else

        @return_to = params[:return_to]

        format.html do
          render :edit,
                 status: :unprocessable_content
        end

        format.json do
          render json: @servicio_maquinaria.errors,
                 status: :unprocessable_content
        end

      end

    end
  end

  # DELETE /servicio_maquinarias/1
  def destroy

    @servicio_maquinaria.destroy!

    respond_to do |format|

      format.html do
        redirect_to servicio_maquinarias_path,
                    notice: "Servicio de maquinaria eliminado correctamente.",
                    status: :see_other
      end

      format.json do
        head :no_content
      end

    end
  end

  private

  def set_servicio_maquinaria
    @servicio_maquinaria =
      ServicioMaquinaria.find(params[:id])
  end

  def servicio_maquinaria_params
    params.require(:servicio_maquinaria).permit(
      :maquinaria_id,
      :fecha,
      :hora
    )
  end
end

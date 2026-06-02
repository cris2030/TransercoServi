class ServiciosController < ApplicationController
  before_action :set_servicio, only: %i[ show edit update destroy ]

  # GET /servicios or /servicios.json
  def index
    @servicios = Servicio.all
  end

  # GET /servicios/1 or /servicios/1.json
  def show
  end

  # GET /servicios/new
  def new
    @servicio = Servicio.new
  end

  # GET /servicios/1/edit
  def edit
  end

  # POST /servicios or /servicios.json
  def create
    @servicio = Servicio.new(servicio_params)

    respond_to do |format|
      if @servicio.save
        format.html { redirect_to @servicio, notice: "Servicio was successfully created." }
        format.json { render :show, status: :created, location: @servicio }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @servicio.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /servicios/1 or /servicios/1.json
  def update
    respond_to do |format|
      if @servicio.update(servicio_params)
        format.html { redirect_to @servicio, notice: "Servicio was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @servicio }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @servicio.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /servicios/1 or /servicios/1.json
  def destroy
    @servicio.destroy!

    respond_to do |format|
      format.html { redirect_to servicios_path, notice: "Servicio was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_servicio
      @servicio = Servicio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def servicio_params
      params.require(:servicio).permit(:unidad_id, :kilometraje, :fecha, :nom_mecanico)
    end
end

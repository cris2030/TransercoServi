class UnidadesController < ApplicationController
  before_action :set_unidad, only: %i[ show edit update destroy ]

  # GET /unidades or /unidades.json
  def index
    @unidades = Unidad.all
  end

  # GET /unidades/1 or /unidades/1.json
  def show
  end

  # GET /unidades/new
  def new
    @unidad = Unidad.new
  end

  # GET /unidades/1/edit
  def edit
  end

  # POST /unidades or /unidades.json
  def create
    @unidad = Unidad.new(unidad_params)

    respond_to do |format|
      if @unidad.save
        format.html { redirect_to @unidad, notice: "Unidad was successfully created." }
        format.json { render :show, status: :created, location: @unidad }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @unidad.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /unidades/1 or /unidades/1.json
  def update
    respond_to do |format|
      if @unidad.update(unidad_params)
        format.html { redirect_to @unidad, notice: "Unidad was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @unidad }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @unidad.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /unidades/1 or /unidades/1.json
  def destroy
    @unidad.destroy!

    respond_to do |format|
      format.html { redirect_to unidades_path, notice: "Unidad was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end
  
  def sync_from_api
    api = LinkerApi.new

    if Unidad.sync_from_linker_api(api)
      redirect_to unidades_path, notice: "Unidades sincronizadas correctamente"
    else
      redirect_to unidades_path, alert: "Error al sincronizar unidades"
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unidad
      @unidad = Unidad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def unidad_params
      params.require(:unidad).permit(:unitID, :codigo, :placa)
    end
end

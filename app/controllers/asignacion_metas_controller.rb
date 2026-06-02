class AsignacionMetasController < ApplicationController
  before_action :set_asignacion_meta, only: %i[ show edit update destroy ]

  # GET /asignacion_metas or /asignacion_metas.json
  def index
    @asignacion_metas = AsignacionMeta.all
  end

  # GET /asignacion_metas/1 or /asignacion_metas/1.json
  def show
  end

  # GET /asignacion_metas/new
  def new
    @asignacion_meta = AsignacionMeta.new
  end

  # GET /asignacion_metas/1/edit
  def edit
  end

  # POST /asignacion_metas or /asignacion_metas.json
  def create
    @asignacion_meta = AsignacionMeta.new(asignacion_meta_params)

    respond_to do |format|
      if @asignacion_meta.save
        format.html { redirect_to @asignacion_meta, notice: "Asignacion meta was successfully created." }
        format.json { render :show, status: :created, location: @asignacion_meta }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @asignacion_meta.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /asignacion_metas/1 or /asignacion_metas/1.json
  def update
    respond_to do |format|
      if @asignacion_meta.update(asignacion_meta_params)
        format.html { redirect_to @asignacion_meta, notice: "Asignacion meta was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @asignacion_meta }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @asignacion_meta.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /asignacion_metas/1 or /asignacion_metas/1.json
  def destroy
    @asignacion_meta.destroy!

    respond_to do |format|
      format.html { redirect_to asignacion_metas_path, notice: "Asignacion meta was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asignacion_meta
      @asignacion_meta = AsignacionMeta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asignacion_meta_params
      params.require(:asignacion_meta).permit(:unidad_id, :meta_id)
    end
end

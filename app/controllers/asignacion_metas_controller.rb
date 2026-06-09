class AsignacionMetasController < ApplicationController
  before_action :set_asignacion_meta, only: %i[show destroy]

  def index
    @metas = Meta.includes(:unidades)
  end

  def show
  end

  def new
    @asignacion_meta = AsignacionMeta.new
  end

  def edit
    @meta = Meta.includes(:unidades).find(params[:id])

    @asignacion_meta = AsignacionMeta.new
    @asignacion_meta.meta_id = @meta.id
  end

  def create
    meta_id = params.dig(:asignacion_meta, :meta_id)
    unidad_ids = params[:unidad_ids] || []

    if meta_id.blank?
      flash.now[:alert] = "Debe seleccionar una meta"
      @asignacion_meta = AsignacionMeta.new
      render :new, status: :unprocessable_entity
      return
    end

    if unidad_ids.blank?
      flash.now[:alert] = "Debe seleccionar al menos una unidad"
      @asignacion_meta = AsignacionMeta.new(meta_id: meta_id)
      render :new, status: :unprocessable_entity
      return
    end

    unidad_ids.each do |unidad_id|
      AsignacionMeta.find_or_create_by(
        meta_id: meta_id,
        unidad_id: unidad_id
      )
    end

    redirect_to asignacion_metas_path,
                notice: "Asignaciones creadas correctamente"
  end

  def update
    meta = Meta.includes(:unidades).find(params[:id])

    meta_id = params.dig(:asignacion_meta, :meta_id)
    unidad_ids = params[:unidad_ids] || []

    if meta_id.blank?
      flash.now[:alert] = "Debe seleccionar una meta"
      @meta = meta
      @asignacion_meta = AsignacionMeta.new
      render :edit, status: :unprocessable_entity
      return
    end

    meta.unidad_ids = unidad_ids.map(&:to_i)

    redirect_to asignacion_metas_path,
                notice: "Asignaciones actualizadas correctamente"
  end

  def destroy
    @asignacion_meta.destroy!

    redirect_to asignacion_metas_path,
                notice: "Asignacion eliminada correctamente"
  end

  private

  def set_asignacion_meta
    @asignacion_meta = AsignacionMeta.find(params[:id])
  end
end
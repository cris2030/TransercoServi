class AsignacionMaquinariaMetasController < ApplicationController
  before_action :set_asignacion_maquinaria_meta,
                only: %i[show destroy]

  def index
    @metas = Meta.includes(:maquinarias)
  end

  def show
  end

  def new
    @asignacion_maquinaria_meta =
      AsignacionMaquinariaMeta.new
  end

  def edit
    @meta = Meta.includes(:maquinarias).find(params[:id])

    @asignacion_maquinaria_meta =
      AsignacionMaquinariaMeta.new

    @asignacion_maquinaria_meta.meta_id = @meta.id
  end

  def create
    meta_id =
      params.dig(:asignacion_maquinaria_meta, :meta_id)

    maquinaria_ids =
      params[:maquinaria_ids] || []

    if meta_id.blank?

      flash.now[:alert] =
        "Debe seleccionar una meta"

      @asignacion_maquinaria_meta =
        AsignacionMaquinariaMeta.new

      render :new,
             status: :unprocessable_entity

      return
    end

    if maquinaria_ids.blank?

      flash.now[:alert] =
        "Debe seleccionar al menos una maquinaria"

      @asignacion_maquinaria_meta =
        AsignacionMaquinariaMeta.new(
          meta_id: meta_id
        )

      render :new,
             status: :unprocessable_entity

      return
    end

    maquinaria_ids.each do |maquinaria_id|

      AsignacionMaquinariaMeta.find_or_create_by(
        meta_id: meta_id,
        maquinaria_id: maquinaria_id
      )

    end

    redirect_to asignacion_maquinaria_metas_path,
                notice: "Asignaciones creadas correctamente"
  end

  def update

    meta =
      Meta.includes(:maquinarias).find(params[:id])

    meta_id =
      params.dig(:asignacion_maquinaria_meta, :meta_id)

    maquinaria_ids =
      params[:maquinaria_ids] || []

    if meta_id.blank?

      flash.now[:alert] =
        "Debe seleccionar una meta"

      @meta = meta

      @asignacion_maquinaria_meta =
        AsignacionMaquinariaMeta.new

      render :edit,
             status: :unprocessable_entity

      return
    end

    meta.maquinaria_ids =
      maquinaria_ids.map(&:to_i)

    redirect_to asignacion_maquinaria_metas_path,
                notice: "Asignaciones actualizadas correctamente"
  end

  def destroy

    @asignacion_maquinaria_meta.destroy!

    redirect_to asignacion_maquinaria_metas_path,
                notice: "Asignación eliminada correctamente"
  end

  private

  def set_asignacion_maquinaria_meta
    @asignacion_maquinaria_meta =
      AsignacionMaquinariaMeta.find(params[:id])
  end
end

class MetaNotificacionesController < ApplicationController

  # GET /meta_notificaciones or /meta_notificaciones.json
  def index
    @metas = Meta.includes(:meta_notificaciones)
  end

  # GET /meta_notificaciones/1 or /meta_notificaciones/1.json
  def show
  end

  # GET /meta_notificaciones/new
  def new
    @meta_notificacion = MetaNotificacion.new
  end

  # GET /meta_notificaciones/1/edit
  def edit
    @meta = Meta.find(params[:id])
    @users = User.order(:email)

    @config = @meta.meta_notificaciones.group_by(&:user_id)
  end

  def update
    @meta = Meta.find(params[:id])

    # limpiar configuraciones anteriores
    @meta.meta_notificaciones.delete_all

    params[:config]&.each do |_, data|

      next if data[:estados].blank?

      data[:estados].each do |estado|

        @meta.meta_notificaciones.create!(
          user_id: data[:user_id],
          estado: estado
        )

      end
    end

    redirect_to meta_notificaciones_path,
                notice: "Configuración actualizada"
  end


  # POST /meta_notificaciones or /meta_notificaciones.json
  def create
    @meta_notificacion = MetaNotificacion.new(meta_notificacion_params)

    respond_to do |format|
      if @meta_notificacion.save
        format.html { redirect_to @meta_notificacion, notice: "Meta notificacion was successfully created." }
        format.json { render :show, status: :created, location: @meta_notificacion }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @meta_notificacion.errors, status: :unprocessable_content }
      end
    end
  end
  
  # DELETE /meta_notificaciones/1 or /meta_notificaciones/1.json
  def destroy
    @meta_notificacion.destroy!

    respond_to do |format|
      format.html { redirect_to meta_notificaciones_path, notice: "Meta notificacion was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meta_notificacion
      @meta_notificacion = MetaNotificacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meta_notificacion_params
      params.require(:meta_notificacion).permit(:meta_id, :user_id, :estado)
    end
end

class MaquinariasController < ApplicationController
  before_action :set_maquinaria, only: %i[show edit update destroy]

  # GET /maquinarias
  def index
    @maquinarias = Maquinaria.all
  end

  # GET /maquinarias/1
  def show
  end

  # GET /maquinarias/new
  def new
    @maquinaria = Maquinaria.new
  end

  # GET /maquinarias/1/edit
  def edit
  end

  # POST /maquinarias
  def create
    @maquinaria = Maquinaria.new(maquinaria_params)

    respond_to do |format|
      if @maquinaria.save
        format.html do
          redirect_to @maquinaria,
                      notice: "Maquinaria creada correctamente."
        end

        format.json do
          render :show,
                 status: :created,
                 location: @maquinaria
        end
      else
        format.html do
          render :new,
                 status: :unprocessable_content
        end

        format.json do
          render json: @maquinaria.errors,
                 status: :unprocessable_content
        end
      end
    end
  end

  # PATCH/PUT /maquinarias/1
  def update
    respond_to do |format|
      if @maquinaria.update(maquinaria_params)
        format.html do
          redirect_to @maquinaria,
                      notice: "Maquinaria actualizada correctamente.",
                      status: :see_other
        end

        format.json do
          render :show,
                 status: :ok,
                 location: @maquinaria
        end
      else
        format.html do
          render :edit,
                 status: :unprocessable_content
        end

        format.json do
          render json: @maquinaria.errors,
                 status: :unprocessable_content
        end
      end
    end
  end

  # DELETE /maquinarias/1
  def destroy
    @maquinaria.destroy!

    respond_to do |format|
      format.html do
        redirect_to maquinarias_path,
                    notice: "Maquinaria eliminada correctamente.",
                    status: :see_other
      end

      format.json do
        head :no_content
      end
    end
  end

  private

  def set_maquinaria
    @maquinaria = Maquinaria.find(params[:id])
  end

  def maquinaria_params
    params.require(:maquinaria).permit(
      :nombre,
      :codigo,
      :numero_serie
    )
  end
end

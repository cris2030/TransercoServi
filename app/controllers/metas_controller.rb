class MetasController < ApplicationController
  before_action :set_meta, only: %i[ show edit update destroy ]

  # GET /metas or /metas.json
  def index
    @metas = Meta.all
  end

  # GET /metas/1 or /metas/1.json
  def show
  end

  # GET /metas/new
  def new
    @meta = Meta.new
  end

  # GET /metas/1/edit
  def edit
  end

  # POST /metas or /metas.json
  def create
    @meta = Meta.new(meta_params)

    respond_to do |format|
      if @meta.save
        format.html { redirect_to @meta, notice: "Meta was successfully created." }
        format.json { render :show, status: :created, location: @meta }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @meta.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /metas/1 or /metas/1.json
  def update
    respond_to do |format|
      if @meta.update(meta_params)
        format.html { redirect_to @meta, notice: "Meta was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @meta }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @meta.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /metas/1 or /metas/1.json
  def destroy
    @meta.destroy!

    respond_to do |format|
      format.html { redirect_to metas_path, notice: "Meta was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meta
      @meta = Meta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meta_params
      params.require(:meta).permit(:nombre, :kilometraje_inicio, :kilometraje_final, :color, :nivel_imp)
    end
end

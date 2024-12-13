class RegionsController < ApplicationController
  before_action :authorize!
  def index
    @regions = Region.all
  end

  def new
    @region = Region.new
  end

  def edit
    region
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      redirect_to regions_url(), notice: "Region creada con éxito."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if region.update(region_params)
      redirect_to regions_url(@region), notice: "Region Actualizada con exito."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    region.destroy
    redirect_to regions_url, notice: "region eliminada correctamente."
  end

  private

    def region
      @region = Region.find(params[:id])
    end

    def region_params
      params.require(:region).permit(:name)
    end
end

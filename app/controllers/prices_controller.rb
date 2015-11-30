class PricesController < ApplicationController
  before_action :set_price, only: :destroy
  before_filter :set_station
  before_filter :load_fuels, only: [:new, :create]

  load_and_authorize_resource
  skip_load_resource only: :new

  # GET /prices/new
  def new
    @price = @station.prices.new
    render layout: false
  end

  # POST /prices
  # POST /prices.json
  def create
    @price = @station.prices.new(price_params)

    respond_to do |format|
      if @price.save
        format.html { redirect_to @station, notice: t('price_successfully_created') }
        format.json { render :show, status: :created, location: @price }
      else
        format.html { render :new }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prices/1
  # DELETE /prices/1.json
  def destroy
    @price.destroy
    respond_to do |format|
      format.html { redirect_to @station, notice: t('price_successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @price = Price.find(params[:id])
    end

    def set_station
      @station = Station.find(params[:station_id]) if params[:station_id]
    end

    def load_fuels
      @fuels = Fuel.order(:name)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_params
      params.require(:price).permit(:fuel_id, :station_id, :masked_value)
    end
end

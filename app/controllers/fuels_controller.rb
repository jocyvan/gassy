class FuelsController < ApplicationController
  before_action :set_fuel, only: [:show, :edit, :update, :destroy]

  authorize_resource

  # GET /fuels
  # GET /fuels.json
  def index
    @fuels = Fuel.all
  end

  # GET /fuels/1
  # GET /fuels/1.json
  def show
  end

  # GET /fuels/new
  def new
    @fuel = Fuel.new
    render layout: false
  end

  # GET /fuels/1/edit
  def edit
    render layout: false
  end

  # POST /fuels
  # POST /fuels.json
  def create
    @fuel = Fuel.new(fuel_params)

    respond_to do |format|
      if @fuel.save
        format.html { redirect_to fuels_url, notice: 'Fuel was successfully created.' }
        format.json { render :show, status: :created, location: @fuel }
      else
        format.html { render :new }
        format.json { render json: @fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fuels/1
  # PATCH/PUT /fuels/1.json
  def update
    respond_to do |format|
      if @fuel.update(fuel_params)
        format.html { redirect_to fuels_url, notice: 'Fuel was successfully updated.' }
        format.json { render :show, status: :ok, location: @fuel }
      else
        format.html { render :edit }
        format.json { render json: @fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fuels/1
  # DELETE /fuels/1.json
  def destroy
    if @fuel.prices.count == 0
      @fuel.destroy
      respond_to do |format|
        format.html { redirect_to fuels_url, notice: 'Fuel was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to fuels_url, alert: 'Prices has that fuel. Just inative it.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fuel
      @fuel = Fuel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fuel_params
      params.require(:fuel).permit(:name, :status)
    end
end

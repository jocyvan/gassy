class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy, :like, :unlike, :follow]

  impressionist :actions => [:show]

  authorize_resource

  # GET /stations
  # GET /stations.json
  def index
    @stations = Station.all.page(params[:page])
    authorize! :list, Station
  end

  def my
    @stations = current_user.stations.where("name ILIKE ?", "%#{params[:q]}%").page(params[:page])
    render :index
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
    @prices = @station.prices
    @rates = @station.rates
    @my_rate = @rates.where(user: current_user).first_or_initialize
    @comment = Comment.new(user: signed_in? ? current_user : nil)
  end

  # GET /stations/new
  def new
    @station = current_user.stations.new
  end

  # GET /stations/1/edit
  def edit
  end

  # POST /stations
  # POST /stations.json
  def create
    @station = current_user.stations.new(station_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to @station, notice: t('station_successfully_created') }
        format.json { render :show, status: :created, location: @station }
      else
        format.html { render :new }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    respond_to do |format|
      if @station.update(station_params)
        format.html { redirect_to @station, notice: t('station_successfully_updated') }
        format.json { render :show, status: :ok, location: @station }
      else
        format.html { render :edit }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station.destroy
    respond_to do |format|
      format.html { redirect_to my_stations_url, notice: t('station_successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  def like
    @rate = Rate.where(user: current_user, station: @station).first
    if @rate
      @rate.update_attribute(:status, 0)
    else
      @rate = Rate.create!(user: current_user, station: @station, status: :like)
    end

    render :rate_status
  end

  def unlike
    @rate = Rate.where(user: current_user, station: @station).first
    if @rate
      @rate.update_attribute(:status, 1)
    else
      @rate = Rate.create!(user: current_user, station: @station, status: :unlike)
    end

    render :rate_status
  end

  def favorites
    @stations = current_user.followed_stations.where("name ILIKE ?", "%#{params[:q]}%").page(params[:page])

    render :index
  end

  def follow
    if current_user.followed_stations.include?(@station)
      follow = current_user.follows.where(station_id: @station.id)
      if follow.destroy_all
        @followed = false
      else
        @followed = true
      end
    else
      follow = Follow.new(user: current_user, station: @station)
      if follow.save
        @followed = true
      else
        @followed = false
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station
      @station = Station.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
      params.require(:station).permit(:name, :city, :latitude, :longitude)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def rate_params
    #   params.require(:rate).permit(:user, :station, :status)
    # end
end

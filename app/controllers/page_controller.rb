class PageController < ApplicationController
  def home
    @stations = Station.includes(:prices => :fuel).where("name LIKE ?", "%#{params[:q]}%").page(params[:page]).per(30)
  end
end

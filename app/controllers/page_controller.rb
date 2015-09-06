class PageController < ApplicationController
  def home
    @stations = Station.all.includes(:prices).page(params[:page])
  end
end

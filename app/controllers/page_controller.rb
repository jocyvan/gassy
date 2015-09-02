class PageController < ApplicationController
  def home
    @stations = Station.all.includes(:prices)
  end
end

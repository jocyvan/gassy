class CommentsController < ApplicationController
  before_filter :set_station

  def create
    @comment = @station.comments.new(comment_params)
    @comment.user = current_user if signed_in?

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @station, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to @station }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
  end

  private

    def set_station
      @station = Station.find(params[:station_id])
    end

    def comment_params
      params.require(:comment).permit(:name, :content)
    end
end

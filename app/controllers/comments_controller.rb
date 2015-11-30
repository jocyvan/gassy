class CommentsController < ApplicationController
  before_filter :set_station

  authorize_resource

  def create
    @comment = @station.comments.new(comment_params)
    @comment.user = current_user if signed_in?

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @station, notice: t('comment_successfully_created') }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to @station, alert: t('required_fields') }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @station, notice: t('comment_successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  private
    def set_station
      @station = Station.find(params[:station_id])
    end

    def comment_params
      params.require(:comment).permit(:name, :content)
    end
end

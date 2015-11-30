require "spec_helper"

describe CommentsController do
  describe 'POST create' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        @station = FactoryGirl.create(:station)
      end

      context 'with valid attributes' do
        it 'creates a new comment' do
          expect {
            post :create, station_id: @station, comment: FactoryGirl.attributes_for(:comment, station_id: @station)
          }.to change(Comment, :count).by(1)
        end

        it "redirects to the new comment's station" do
          post :create, station_id: @station, comment: FactoryGirl.attributes_for(:comment)
          expect(response).to redirect_to @station
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new comment' do
          expect {
            post :create, station_id: @station, comment: FactoryGirl.attributes_for(:comment, content: nil)
          }.to_not change(Comment, :count)
        end

        it 'redirects to the station' do
          post :create, station_id: @station, comment: FactoryGirl.attributes_for(:comment, content: nil)
          expect(response).to redirect_to @station
        end
      end
    end
  end

  describe 'DELETE destroy' do
    context 'administrator' do
      before do
        admin = FactoryGirl.create(:admin)
        sign_in admin
        @station = FactoryGirl.create(:station)
      end

      before :each do
        @comment = FactoryGirl.create(:comment)
      end

      it 'deletes the comment' do
        expect {
          delete :destroy, station_id: @station, id: @comment
        }.to change(Comment, :count).by(-1)
      end

      it "redirects to comment's station" do
        delete :destroy, station_id: @station, id: @comment
        expect(response).to redirect_to @station
      end
    end
  end
end

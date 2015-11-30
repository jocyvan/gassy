require "spec_helper"

describe PricesController do
  describe 'GET new' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        @station = FactoryGirl.create(:station, user: user)
      end

      it 'assigns a new price to @price' do
        get :new, station_id: @station
        expect(response).to have_http_status(:success)
        expect(assigns(:price)).to be_a_new(Price)
        expect(response).to render_template :new
        expect(response).to render_template(layout: false)
      end
    end
  end

  describe 'POST create' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        @fuel = FactoryGirl.create(:fuel_gasoline)
        @station = FactoryGirl.create(:station, user: user)
      end

      context 'with valid attributes' do
        it 'creates a new price' do
          expect {
            post :create, station_id: @station, price: FactoryGirl.attributes_for(:price_gasoline, station_id: @station, fuel_id: @fuel)
          }.to change(Price, :count).by(1)
        end

        it "redirects to the new price's station" do
          post :create, station_id: @station, price: FactoryGirl.attributes_for(:price_gasoline, station_id: @station, fuel_id: @fuel)
          expect(response).to redirect_to @station
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new price' do
          expect {
            post :create, station_id: @station, price: FactoryGirl.attributes_for(:price_gasoline, station_id: @station, fuel_id: nil)
          }.to_not change(Price, :count)
        end

        it 're-renders the new method' do
          post :create, station_id: @station, price: FactoryGirl.attributes_for(:price_gasoline, station_id: @station, fuel_id: nil)
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'DELETE destroy' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        @station = FactoryGirl.create(:station, user: user)
      end

      before :each do
        @price = FactoryGirl.create(:price_gasoline, station: @station)
      end

      it 'deletes the price' do
        expect {
          delete :destroy, station_id: @station, id: @price
        }.to change(Price, :count).by(-1)
      end

      it "redirects to price's station" do
        delete :destroy, station_id: @station, id: @price
        expect(response).to redirect_to @station
      end
    end
  end
end

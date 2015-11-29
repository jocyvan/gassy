require "spec_helper"

describe StationsController do
  describe 'GET index' do
    context 'administrator' do
      before do
        admin = FactoryGirl.create(:admin)
        sign_in admin
        @station = FactoryGirl.create(:station)
      end

      it 'populates an array of stations' do
        get :index
        expect(response).to have_http_status(:success)
        expect(assigns(:stations)).to eq([@station])
        expect(response).to render_template :index
      end
    end

    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
      end

      it 'not authorized to get index' do
        get :index
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET my' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        @station = FactoryGirl.create(:station, user: user)
      end

      it 'populates an array of my stations' do
        get :my
        expect(response).to have_http_status(:success)
        expect(assigns(:stations)).to eq([@station])
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET favorites' do
    context 'normal user' do
      before do
        @user = FactoryGirl.create(:user)
        sign_in @user
        @station = FactoryGirl.create(:station)
      end

      it 'populates an array of my favorite stations' do
        FactoryGirl.create(:follow, user: @user, station: @station)

        get :favorites
        expect(response).to have_http_status(:success)
        expect(assigns(:stations)).to eq([@station])
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET show' do
    context 'guest' do
      before do
        @station = FactoryGirl.create(:station)
      end

      it 'assigns the requested station to @station' do
        get :show, id: @station
        expect(response).to have_http_status(:success)
        expect(assigns(:station)).to eq(@station)
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET new' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
      end

      it 'assigns a new station to @station' do
        get :new
        expect(response).to have_http_status(:success)
        expect(assigns(:station)).to be_a_new(Station)
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST create' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
      end

      context 'with valid attributes' do
        it 'creates a new station' do
          expect {
            post :create, station: FactoryGirl.attributes_for(:station)
          }.to change(Station, :count).by(1)
        end

        it 'redirects to the new station' do
          post :create, station: FactoryGirl.attributes_for(:station)
          expect(response).to redirect_to Station.last
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new station' do
          expect {
            post :create, station: FactoryGirl.attributes_for(:station, name: nil)
          }.to_not change(Station, :count)
        end

        it 're-renders the new method' do
          post :create, station: FactoryGirl.attributes_for(:station, name: nil)
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'GET edit' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        @station = FactoryGirl.create(:station, user: user)
      end

      it 'locates the requested @station' do
        get :edit, id: @station
        expect(response).to have_http_status(:success)
        expect(assigns(:station)).to eq(@station)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PUT update' do
    context 'normal user' do
      before do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      before :each do
        @station = FactoryGirl.create(:station, user: @user)
      end

      context 'valid attributes' do
        it "changes @station's attributes" do
          put :update, id: @station, station: FactoryGirl.attributes_for(:station, name: 'Other name')
          @station.reload
          expect(@station.name).to eq('Other name')
        end

        it 'redirects to the updated station' do
          put :update, id: @station, station: FactoryGirl.attributes_for(:station)
          expect(response).to redirect_to @station
        end
      end

      context 'invalid attributes' do
        it "does not change @station's attributes" do
          put :update, id: @station, station: FactoryGirl.attributes_for(:station, name: nil)
          @station.reload
          expect(@station.name).to_not be_nil
        end

        it 're-renders the edit method' do
          put :update, id: @station, station: FactoryGirl.attributes_for(:station, name: nil)
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'DELETE destroy' do
    context 'normal user' do
      before do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      before :each do
        @station = FactoryGirl.create(:station, user: @user)
      end

      it 'deletes the own station' do
        expect {
          delete :destroy, id: @station
        }.to change(Station, :count).by(-1)
      end

      it 'redirects to stations#my' do
        delete :destroy, id: @station
        expect(response).to redirect_to my_stations_url
      end
    end
  end

  describe 'GET like' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        @station = FactoryGirl.create(:station)
      end

      it 'like stations' do
        xhr :get, :like, id: @station
        expect(response).to have_http_status(:success)
        expect(response).to render_template :rate_status
        @station.reload
        expect(@station.rates.last.status).to eq('like')
      end
    end
  end

  describe 'GET unlike' do
    context 'normal user' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        @station = FactoryGirl.create(:station)
      end

      it 'unlike stations' do
        xhr :get, :unlike, id: @station
        expect(response).to have_http_status(:success)
        expect(response).to render_template :rate_status
        @station.reload
        expect(@station.rates.last.status).to eq('unlike')
      end
    end
  end

  describe 'GET follow' do
    context 'normal user' do
      before do
        @user = FactoryGirl.create(:user)
        sign_in @user
        @station = FactoryGirl.create(:station)
      end

      it 'follow stations' do
        xhr :get, :follow, id: @station
        expect(response).to have_http_status(:success)
        expect(response).to render_template :follow
        expect(@user.followed_stations).to include(@station)
      end

      it 'unfollow stations' do
        FactoryGirl.create(:follow, user: @user, station: @station)

        xhr :get, :follow, id: @station
        expect(response).to have_http_status(:success)
        expect(@user.followed_stations).to_not include(@station)
      end
    end
  end
end

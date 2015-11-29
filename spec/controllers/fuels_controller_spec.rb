require "spec_helper"

describe FuelsController do
  describe 'GET index' do
    context 'administrator' do
      before do
        admin = FactoryGirl.create(:admin)
        sign_in admin
        @fuel = FactoryGirl.create(:fuel_gasoline)
      end

      it 'populates an array of fuels' do
        get :index
        expect(response).to have_http_status(:success)
        expect(assigns(:fuels)).to eq([@fuel])
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

  describe 'GET new' do
    context 'administrator' do
      before do
        admin = FactoryGirl.create(:admin)
        sign_in admin
      end

      it 'assigns a new fuel to @fuel' do
        get :new
        expect(response).to have_http_status(:success)
        expect(assigns(:fuel)).to be_a_new(Fuel)
        expect(response).to render_template :new
        expect(response).to render_template(layout: false)
      end
    end
  end

  describe 'POST create' do
    context 'administrator' do
      before do
        admin = FactoryGirl.create(:admin)
        sign_in admin
      end

      context 'with valid attributes' do
        it 'creates a new fuel' do
          expect {
            post :create, fuel: FactoryGirl.attributes_for(:fuel_gasoline)
          }.to change(Fuel, :count).by(1)
        end

        it 'redirects to fuels#index' do
          post :create, fuel: FactoryGirl.attributes_for(:fuel_gasoline)
          expect(response).to redirect_to fuels_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new fuel' do
          expect {
            post :create, fuel: FactoryGirl.attributes_for(:fuel_gasoline, name: nil)
          }.to_not change(Fuel, :count)
        end

        it 're-renders the new method' do
          post :create, fuel: FactoryGirl.attributes_for(:fuel_gasoline, name: nil)
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'GET edit' do
    context 'administrator' do
      before do
        admin = FactoryGirl.create(:admin)
        sign_in admin
        @fuel = FactoryGirl.create(:fuel_gasoline)
      end

      it 'locates the requested @fuel' do
        get :edit, id: @fuel
        expect(response).to have_http_status(:success)
        expect(assigns(:fuel)).to eq(@fuel)
        expect(response).to render_template :edit
        expect(response).to render_template(layout: false)
      end
    end
  end

  describe 'PUT update' do
    context 'administrator' do
      before do
        admin = FactoryGirl.create(:admin)
        sign_in admin
      end

      before :each do
        @fuel = FactoryGirl.create(:fuel_gasoline)
      end

      context 'valid attributes' do
        it "changes @fuel's attributes" do
          put :update, id: @fuel, fuel: FactoryGirl.attributes_for(:fuel_gasoline, name: 'Other name')
          @fuel.reload
          expect(@fuel.name).to eq('Other name')
        end

        it 'redirects to fuels#index' do
          put :update, id: @fuel, fuel: FactoryGirl.attributes_for(:fuel_gasoline)
          expect(response).to redirect_to fuels_path
        end
      end

      context 'invalid attributes' do
        it "does not change @fuel's attributes" do
          put :update, id: @fuel, fuel: FactoryGirl.attributes_for(:fuel_gasoline, name: nil)
          @fuel.reload
          expect(@fuel.name).to_not be_nil
        end

        it 're-renders the edit method' do
          put :update, id: @fuel, fuel: FactoryGirl.attributes_for(:fuel_gasoline, name: nil)
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'DELETE destroy' do
    context 'administrator' do
      before do
        admin = FactoryGirl.create(:admin)
        sign_in admin
      end

      before :each do
        @fuel = FactoryGirl.create(:fuel_gasoline)
      end

      it 'deletes the fuel' do
        expect {
          delete :destroy, id: @fuel
        }.to change(Fuel, :count).by(-1)
      end

      it 'redirects to fuels#index' do
        delete :destroy, id: @fuel
        expect(response).to redirect_to fuels_url
      end
    end
  end
end

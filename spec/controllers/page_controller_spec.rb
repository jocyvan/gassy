require "spec_helper"

describe PageController do
  describe 'GET home' do
    context 'guest' do
      before do
        @station = FactoryGirl.create(:station, name: 'Other station')
      end

      it 'searches for an array of users' do
        get :home, q: 'other'
        expect(response).to have_http_status(:success)
        expect(assigns(:stations)).to include @station
        expect(response).to render_template :home
      end
    end
  end
end

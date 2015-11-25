require "spec_helper"

describe Follow do
  subject { FactoryGirl.create(:follow) }

  it { should have_db_index([:user_id, :station_id]) }
  it { should have_db_index([:station_id, :user_id]) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:station_id) }

  it { should belong_to(:user) }
  it { should belong_to(:station).counter_cache(true) }
end

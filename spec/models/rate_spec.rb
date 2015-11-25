require "spec_helper"

describe Rate do
  subject { FactoryGirl.create(:rate) }

  it { should define_enum_for(:status) }

  it { should have_db_index(:user_id) }
  it { should have_db_index(:station_id) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:station_id) }

  it { should belong_to(:user) }
  it { should belong_to(:station).counter_cache(true) }

  it 'should be included rate in this month scope' do
    expect(Rate.this_month).to include subject
  end

  it 'should be included rate in prev month scope' do
    expect(Rate.prev_month).to include FactoryGirl.create(:rate, created_at: Date.today - 1.month)
  end

  it 'should be included rate in prev_2 month scope' do
    expect(Rate.prev_2_month).to include FactoryGirl.create(:rate, created_at: Date.today - 2.months)
  end
end

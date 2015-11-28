require "spec_helper"

describe Price do
  subject { FactoryGirl.create(:price_gasoline) }

  it { should have_db_index([:fuel_id, :station_id]) }
  it { should have_db_index([:station_id, :fuel_id]) }

  it { should validate_presence_of(:fuel_id) }
  it { should validate_presence_of(:station_id) }
  it { should validate_presence_of(:value) }
  it { should validate_numericality_of(:value).is_greater_than(0) }

  it { should belong_to(:fuel) }
  it { should belong_to(:station) }

  it { should delegate_method(:name).to(:station).with_prefix(true) }
  it { should delegate_method(:user_id).to(:station).with_prefix(true) }
  it { should delegate_method(:name).to(:fuel).with_prefix(true) }

  it 'should have masked value' do
    subject.masked_value = '3,31'
    expect(subject.value).to eq(3.31)
  end
end

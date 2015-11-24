require "spec_helper"

describe Fuel do
  subject { FactoryGirl.create(:fuel_gasoline) }

  it { should define_enum_for(:status) }

  it { should validate_presence_of(:name) }

  it { should have_many(:prices).dependent(:destroy) }
  it { should have_many(:stations).through(:prices) }
end

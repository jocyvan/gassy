require "spec_helper"

RSpec.describe Station, :type => :model do
  subject { FactoryGirl.create(:station) }

  # it { should have_db_index(:id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:city) }

  it { should belong_to(:user) }
  it { should have_many(:prices).dependent(:destroy) }
  it { should have_many(:rates).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:follows).dependent(:destroy) }
  it { should have_many(:followers) }
end

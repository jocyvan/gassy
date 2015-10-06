require "spec_helper"

RSpec.describe User, :type => :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name).on(:update) }
  it { should validate_presence_of(:email).on(:update) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }

  it { should have_many(:stations) }
  it { should have_many(:comments) }
  it { should have_many(:follows).dependent(:destroy) }
  it { should have_many(:followed_stations) }

  it "should be admin" do
    super_pearson = build(:admin)
    expect(super_pearson.admin?).to be_truthy
  end

  it "should clear user from stations before destroy" do
    user = create(:user)
    station = create(:station, user: user)
    user.destroy
    station.reload
    expect(station.user).to be_nil
  end
end

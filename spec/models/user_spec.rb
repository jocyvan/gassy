require "spec_helper"

describe User do
  subject { FactoryGirl.build(:user) }

  it { should define_enum_for(:role) }

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

  it "should clear user from stations before destroy" do
    station = FactoryGirl.create(:station, user: subject)
    subject.destroy
    station.reload
    expect(station.user).to be nil
  end
end

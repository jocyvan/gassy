require "rails_helper"

RSpec.describe User, :type => :model do
  it "should be created" do
    pearson = create(:user)
    expect(pearson.persisted?).to be_truthy
  end

  it "should be admin" do
    super_pearson = create(:admin)
    expect(super_pearson.admin?).to be_truthy
  end

  it "should clear user form stations before destroy" do
    station = create(:station)
    station.user.destroy
    station.reload
    expect(station.user).to be_nil
  end

  it "should validate presence name on create" do
    user = build(:user, name: nil)
    expect(user.valid?).to be_falsey
  end

  it "should validate presence email on create" do
    user = build(:user, email: nil)
    expect(user.valid?).to be_falsey
  end

  it "should validate presence password on create" do
    user = build(:user, password: nil)
    expect(user.valid?).to be_falsey
  end

  it "should validate presence password_confirmation on create" do
    user = build(:user, password_confirmation: nil)
    expect(user.valid?).to be_falsey
  end

  it "should validate presence name on udate" do
    user = create(:user)
    user.name = nil
    expect(user.valid?).to be_falsey
  end

  it "should validate presence email on udate" do
    user = create(:user)
    user.email = nil
    expect(user.valid?).to be_falsey
  end

  it "email should be a valid email" do
    user = build(:user, email: "exemple.com.br")
    expect(user.valid?).to be_falsey
  end

  it "email should be uniqueness" do
    create(:user, email: "uniqueuser@exemple.com.br")
    user = build(:user, email: "uniqueuser@exemple.com.br")
    expect(user.valid?).to be_falsey
  end

  it "should has many stations" do
    user = create(:user)
    create(:station, user: user)
    create(:station, user: user)
    expect(user.stations.size).to be > 1
  end

  it "should has many comments" do
    user = create(:user)
    create(:comment, user: user)
    create(:comment, user: user)
    expect(user.comments.size).to be > 1
  end

  it "should has many follows" do
    user = create(:user)
    create(:follow, user: user)
    create(:follow, user: user)
    expect(user.follows.size).to be > 1
  end

  it "should dependent destroy follows" do
    follow = create(:follow)
    follow_length = Follow.all.size
    follow.user.destroy
    expect(Follow.all.size).to eq(follow_length-1)
  end

  it "should has many followed_stations" do
    user = create(:user)
    station = create(:station, user: user)
    follow = create(:follow, user: user, station: station)
    expect(user.followed_stations.include?(station)).to be_truthy
  end
end

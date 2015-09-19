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
end

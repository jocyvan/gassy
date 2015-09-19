require "rails_helper"

RSpec.describe User, :type => :model do
  it "should be created" do
    pearson = User.create!(name: "Pearson", email: "Pearson@example.com", password: "testes", password_confirmation: "testes")

    expect(pearson.persisted?).to be_truthy
  end
end
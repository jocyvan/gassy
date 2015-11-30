require "spec_helper"
require "cancan/matchers"

describe Ability do
  let(:user) { nil }

  subject { Ability.new(user) }

  context 'administrator' do
    let(:user) { FactoryGirl.create(:admin) }

    it 'should be able to manage everything' do
      expect(subject.can?(:manage, :all)).to be true
    end

    it 'should not be able to delete fuels with price' do
      fuel = FactoryGirl.create(:fuel_gasoline)
      FactoryGirl.create(:price_gasoline, fuel: fuel)
      expect(subject.can?(:destroy, fuel)).to be false
    end
  end

  context 'normal user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    it 'should be able to show own profile' do
      expect(subject.can?(:show, user)).to be true
    end

    it 'should not be able to show other users' do
      expect(subject.can?(:show, other_user)).to be false
    end

    it 'should not be able to list users' do
      expect(subject.can?(:index, User)).to be false
    end

    it 'should not be able to create users' do
      expect(subject.can?(:create, User)).to be false
    end

    it 'should be able to update own profile' do
      expect(subject.can?(:update, subject)).to be false
    end

    it 'should not be able to update other users' do
      expect(subject.can?(:update, other_user)).to be false
    end

    it 'should not be able to delete users' do
      expect(subject.can?(:destroy, User)).to be false
    end

    it 'should not be able to list fuels' do
      expect(subject.can?(:index, Fuel)).to be false
    end

    it 'should not be able to show fuels' do
      expect(subject.can?(:show, Fuel)).to be false
    end

    it 'should not be able to create fuels' do
      expect(subject.can?(:create, FactoryGirl.build(:fuel_gasoline))).to be false
    end

    it 'should not be able to update fuels' do
      expect(subject.can?(:update, FactoryGirl.build(:fuel_gasoline))).to be false
    end

    it 'should not be able to delete fuels' do
      expect(subject.can?(:delete, FactoryGirl.build(:fuel_gasoline))).to be false
    end

    it 'should not be able to list stations' do
      expect(subject.can?(:index, Station)).to be false
    end

    it 'should be able to show stations' do
      expect(subject.can?(:show, Station)).to be true
    end

    it 'should be able to create stations' do
      expect(subject.can?(:create, FactoryGirl.build(:station, user: user))).to be true
    end

    it 'should be able to update own stations' do
      expect(subject.can?(:update, FactoryGirl.build(:station, user: user))).to be true
    end

    it 'should not be able to update other user stations' do
      expect(subject.can?(:update, FactoryGirl.build(:station, user: other_user))).to be false
    end

    it 'should be able to delete own stations' do
      expect(subject.can?(:destroy, FactoryGirl.build(:station, user: user))).to be true
    end

    it 'should not be able to delete other user stations' do
      expect(subject.can?(:destroy, FactoryGirl.build(:station, user: other_user))).to be false
    end

    it 'should be able to list my stations' do
      expect(subject.can?(:my, Station)).to be true
    end

    it 'should be able to list my favorite stations' do
      expect(subject.can?(:favorites, Station)).to be true
    end

    it 'should be able to like stations' do
      expect(subject.can?(:like, FactoryGirl.build(:station))).to be true
    end

    it 'should be able to unlike stations' do
      expect(subject.can?(:unlike, FactoryGirl.build(:station))).to be true
    end

    it 'should be able to follow stations' do
      expect(subject.can?(:follow, FactoryGirl.build(:station))).to be true
    end

    it 'should be able to create prices from own stations' do
      expect(subject.can?(:create, FactoryGirl.build(:price_gasoline, station: FactoryGirl.build(:station, user: user)))).to be true
    end

    it 'should be able to update prices from own stations' do
      expect(subject.can?(:update, FactoryGirl.build(:price_gasoline, station: FactoryGirl.build(:station, user: user)))).to be true
    end

    it "should not be able to update prices from other user's stations" do
      expect(subject.can?(:update, FactoryGirl.build(:price_gasoline, station: FactoryGirl.build(:station, user: other_user)))).to be false
    end

    it 'should be able to delete prices from own stations' do
      expect(subject.can?(:destroy, FactoryGirl.build(:price_gasoline, station: FactoryGirl.build(:station, user: user)))).to be true
    end

    it "should not be able to delete prices from other user's stations" do
      expect(subject.can?(:destroy, FactoryGirl.build(:price_gasoline, station: FactoryGirl.build(:station, user: other_user)))).to be false
    end
  end

  context 'guest' do
    it 'should not be able to list users' do
      expect(subject.can?(:index, User)).to be false
    end

    it 'should not be able to show users' do
      expect(subject.can?(:show, User)).to be false
    end

    it 'should not be able to create users' do
      expect(subject.can?(:create, User)).to be false
    end

    it 'should not be able to update users' do
      expect(subject.can?(:update, User)).to be false
    end

    it 'should not be able to delete users' do
      expect(subject.can?(:destroy, User)).to be false
    end

    it 'should not be able to list fuels' do
      expect(subject.can?(:index, Fuel)).to be false
    end

    it 'should not be able to show fuels' do
      expect(subject.can?(:show, Fuel)).to be false
    end

    it 'should not be able to create fuels' do
      expect(subject.can?(:create, FactoryGirl.build(:fuel_gasoline))).to be false
    end

    it 'should not be able to update fuels' do
      expect(subject.can?(:update, FactoryGirl.build(:fuel_gasoline))).to be false
    end

    it 'should not be able to delete fuels' do
      expect(subject.can?(:delete, FactoryGirl.build(:fuel_gasoline))).to be false
    end

    it 'should not be able to list stations' do
      expect(subject.can?(:index, Station)).to be false
    end

    it 'should be able to show stations' do
      expect(subject.can?(:show, Station)).to be true
    end

    it 'should not be able to create stations' do
      expect(subject.can?(:create, FactoryGirl.build(:station))).to be false
    end

    it 'should not be able to update stations' do
      expect(subject.can?(:update, FactoryGirl.build(:station))).to be false
    end

    it 'should not be able to delete stations' do
      expect(subject.can?(:delete, FactoryGirl.build(:station))).to be false
    end

    it 'should not be able to list my stations' do
      expect(subject.can?(:my, Station)).to be false
    end

    it 'should not be able to list my favorite stations' do
      expect(subject.can?(:favorites, Station)).to be false
    end

    it 'should not be able to like stations' do
      expect(subject.can?(:like, FactoryGirl.build(:station))).to be false
    end

    it 'should not be able to unlike stations' do
      expect(subject.can?(:unlike, FactoryGirl.build(:station))).to be false
    end

    it 'should not be able to follow stations' do
      expect(subject.can?(:follow, FactoryGirl.build(:station))).to be false
    end

    it 'should not be able to create prices' do
      expect(subject.can?(:create, FactoryGirl.build(:price_gasoline))).to be false
    end

    it 'should not be able to update prices' do
      expect(subject.can?(:update, FactoryGirl.build(:price_gasoline))).to be false
    end

    it 'should not be able to delete prices' do
      expect(subject.can?(:destroy, FactoryGirl.build(:price_gasoline))).to be false
    end
  end
end

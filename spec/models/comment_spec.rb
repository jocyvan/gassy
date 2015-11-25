require "spec_helper"

describe Comment do
  subject { FactoryGirl.create(:comment) }

  it { should have_db_index(:user_id) }
  it { should have_db_index(:station_id) }

  context 'normal user' do
    subject { FactoryGirl.create(:comment_with_user) }

    it { should_not validate_presence_of(:name) }
  end

  context 'guest' do
    it { should validate_presence_of(:name) }
  end

  it { should validate_presence_of(:station_id) }
  it { should validate_presence_of(:content) }

  it { should belong_to(:user) }
  it { should belong_to(:station).counter_cache(true) }

  it { should delegate_method(:name).to(:user).with_prefix(true) }

  it 'should be included comment in this month scope' do
    expect(Comment.this_month).to include subject
  end

  it 'should be included comment in prev month scope' do
    expect(Comment.prev_month).to include FactoryGirl.create(:comment, created_at: Date.today - 1.month)
  end

  it 'should be included comment in prev_2 month scope' do
    expect(Comment.prev_2_month).to include FactoryGirl.create(:comment, created_at: Date.today - 2.months)
  end
end

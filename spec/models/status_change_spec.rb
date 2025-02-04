require 'rails_helper'

RSpec.describe StatusChange, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
    it { should have_one(:activity).dependent(:destroy) }
  end

  describe 'callbacks' do
    it 'creates an activity after creation' do
      status_change = create(:status_change)
      expect(status_change.activity).to be_present
    end
  end
end

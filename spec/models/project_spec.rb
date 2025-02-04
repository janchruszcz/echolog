require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:activities).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:status_changes).dependent(:destroy) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(
      not_started: 0,
      in_progress: 1,
      under_review: 2,
      completed: 3
    ) }
  end

  describe '#activity_feed' do
    let(:project) { create(:project, :with_comments, :with_status_changes) }

    it 'returns activities in descending order by created_at' do
      expect(project.activity_feed).to eq(project.activities.order(created_at: :desc))
    end
  end
end

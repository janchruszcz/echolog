require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:projects) }
    it { should have_many(:comments) }
    it { should have_many(:status_changes) }
  end
end

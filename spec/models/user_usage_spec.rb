require 'rails_helper'

RSpec.describe UserUsage, type: :model do
  subject { create(:user_usage) }

  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:path) }
      it { is_expected.to validate_presence_of(:number_of_clicks) }
    end

    describe 'numericality' do
      it { is_expected.to validate_numericality_of(:number_of_clicks).only_integer }
    end
  end
end

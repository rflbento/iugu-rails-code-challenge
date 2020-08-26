require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create(:account) }

  describe 'validations' do
    describe 'association' do
      it { is_expected.to have_many(:transfers) }
    end

    describe 'presence' do
      it { is_expected.to validate_presence_of(:account_number) }
      it { is_expected.to validate_presence_of(:account_name) }
      it { is_expected.to validate_presence_of(:initial_balance) }
      it { is_expected.to validate_presence_of(:token) }
    end

    describe 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:account_number) }
      it { is_expected.to validate_uniqueness_of(:token) }
    end

    describe 'numericality' do
      it { is_expected.to validate_numericality_of(:account_number).only_integer }
      it { is_expected.to validate_numericality_of(:balance).only_integer }
    end
  end
end

require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create(:account) }

  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:id) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:balance) }
      it { is_expected.to validate_presence_of(:token) }
    end

    describe 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:id) }
      it { is_expected.to validate_uniqueness_of(:token) }
    end

    describe 'numericality' do
      it { is_expected.to validate_numericality_of(:balance).only_integer }
    end
  end
end

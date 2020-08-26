require 'rails_helper'

RSpec.describe Transfer, type: :model do
  subject { create(:transfer) }

  describe 'validations' do
    describe 'association' do
      it { is_expected.to belong_to(:account) }
    end

    describe 'presence' do
      it { is_expected.to validate_presence_of(:amount) }
    end

    describe 'numericality' do
      it { is_expected.to validate_numericality_of(:amount).only_integer }
    end
  end
end

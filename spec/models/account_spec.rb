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
      it { is_expected.to validate_numericality_of(:initial_balance).only_integer }
    end

    describe '#balance' do
      context 'quando o saldo deve retornar valor positivo' do
        it 'retorna o saldo' do
          account = create(:account, initial_balance: 10_000)

          create_list(:transfer, 5, account: account, amount: 5000)
          create_list(:transfer, 3, account: account, amount: -2000)

          final_balance = account.balance

          expect(final_balance).to eq(29_000)
        end
      end

      context 'quando o saldo deve retornar valor negativo' do
        it 'retorna o saldo' do
          account = create(:account, initial_balance: 10_000)

          create_list(:transfer, 5, account: account, amount: -5000)
          create_list(:transfer, 3, account: account, amount: 2000)

          final_balance = account.balance

          expect(final_balance).to eq(-9000)
        end
      end

      context 'quando não há transferências' do
        it 'o saldo final é igual ao initial_balance' do
          account = create(:account, initial_balance: 10_000)

          final_balance = account.balance

          expect(final_balance).to eq(account.initial_balance)
        end
      end
    end
  end
end

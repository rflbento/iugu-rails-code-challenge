require 'rails_helper'

RSpec.describe AccountCreateService do
  describe '#create' do
    context 'quando o usuário informa todos os dados da forma correta' do
      it 'cria a conta' do
        account_params = {
          account_number: 77,
          account_name: 'João Alves',
          initial_balance: 300_025
        }

        expect do
          described_class.new(**account_params).create
        end.to change { Account.all.count }.by(1)
      end
    end

    context 'quando o usuário NÃO informa o ID da conta' do
      it 'cria a conta com ID automático' do
        old_account = create(:account, account_number: 77)

        account_params = {
          account_number: nil,
          account_name: 'Usuário sem ID de conta',
          initial_balance: 40_097
        }

        new_account = described_class.new(**account_params).create
        old_account_number = old_account.account_number

        expect(new_account.account_number).to eq(old_account_number + 1)
      end
    end

    context 'quando o usuário informa um ID de conta já existente' do
      it 'NÃO cria a conta' do
        invalid_account_params = {
          account_number: 1010,
          account_name: 'Usuário vai repetir ID',
          initial_balance: 40_097
        }

        create(:account, account_number: 1010)

        expect do
          described_class.new(**invalid_account_params).create
        end.not_to change { Account.all.count }
      end
    end
  end

  describe '.create' do
    it 'inicia o serviço, invoca e retorna o resultado de #create' do
      service = instance_double('AccountCreateService')
      account = instance_double('Account')

      account_params = {
        account_number: 77,
        account_name: 'João Alves',
        initial_balance: 300_025
      }

      expect(described_class).to receive(:new).with(**account_params).once.and_return(service)

      expect(service).to receive(:create).and_return(account)

      expect(described_class.create(**account_params)).to eq(account)
    end
  end
end

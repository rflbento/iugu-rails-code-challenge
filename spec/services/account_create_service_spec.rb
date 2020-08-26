require 'rails_helper'

RSpec.describe AccountCreateService do
  subject do
    described_class.new(
      account_number: account_number, account_name: account_name, balance: balance
    )
  end

  let(:account_number) { 77 }
  let(:account_name) { 'João Alves' }
  let(:balance) { 300_025 }

  describe '#create' do
    context 'quando o usuário informa todos os dados da forma correta' do
      it 'cria a conta' do
        subject.create

        account = Account.last

        expect(account).to be_persisted
        expect(account.account_number).to eq(77)
        expect(account.account_name).to eq('João Alves')
        expect(account.balance).to eq(300_025)
        expect(account.token).not_to be_nil
      end

      it 'retorna mesagem JSON' do
        response = subject.create
        account = Account.last

        expect(response).to eq(
          {
            account_number: account.account_number,
            token: account.token
          }
        )
      end
    end

    context 'quando o usuário NÃO informa o ID da conta' do
      let(:account_number) { nil }
      let(:account_name) { 'Usuário sem ID de conta' }
      let(:balance) { 40_097 }

      let!(:old_account) { create(:account) }
      let!(:last_account) { Account.last }

      it 'cria a conta com ID automático' do
        subject.create

        new_account = Account.last

        expect(new_account).to be_persisted
        expect(new_account.account_number).not_to eq(old_account.account_number)
        expect(new_account.account_name).to eq('Usuário sem ID de conta')
        expect(new_account.balance).to eq(40_097)
        expect(new_account.token).not_to be_nil

        expect(new_account.account_number).to eq("#{last_account.account_number}1".to_i)
      end
    end

    context 'quando o usuário informa um ID de conta já existente' do
      let(:account_number) { 1010 }
      let(:account_name) { 'Usuário sem ID de conta' }
      let(:balance) { 40_097 }

      let!(:old_account) { create(:account, account_number: 1010) }

      it 'NÃO cria a conta' do
        subject.create

        expect(Account.last).to eq(old_account)
      end

      it 'retorna mensagem de "ID já utilizado"' do
        response = subject.create

        expect(response).to eq({ error: 'Este ID de conta já foi utilizado.' })
      end
    end
  end

  describe '.create' do
    it 'inicia o serviço, invoca e retorna o resultado de #create' do
      service = instance_double('AccountCreateService')
      account = instance_double('Account')

      expect(described_class).to receive(:new).with(
        account_number: account_number,
        account_name: account_name,
        balance: balance
      ).once.and_return(service)

      expect(service).to receive(:create).and_return(account)

      expect(
        described_class.create(
          account_number: account_number,
          account_name: account_name,
          balance: balance
        )
      ).to eq(account)
    end
  end
end

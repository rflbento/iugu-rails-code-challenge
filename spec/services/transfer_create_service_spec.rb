require 'rails_helper'

RSpec.describe TransferCreateService do
  describe '#create' do
    context 'quando o usuário informa IDs de contas válidas' do
      context 'quando o valor da transferência é maior que 0' do
        it 'cria uma transferência com valor negativo para o source' do
          source_account = create(:account)
          destiny_account = create(
            :account,
            account_number: 456,
            account_name: 'Silvio Santos',
            balance: 10_000,
            token: 'SiLvIoDuMMyToKeN'
          )

          source_id = source_account.account_number
          destiny_id = destiny_account.account_number
          amount = 5000

          described_class.new(
            source_id: source_id, destiny_id: destiny_id, amount: amount
          ).create

          expect(source_account.transfers.last.amount).to eq(-5000)
        end

        it 'cria uma transferência com valor positivo para o destiny' do
          source_account = create(:account)
          destiny_account = create(
            :account,
            account_number: 456,
            account_name: 'Silvio Santos',
            balance: 10_000,
            token: 'SiLvIoDuMMyToKeN'
          )

          source_id = source_account.account_number
          destiny_id = destiny_account.account_number
          amount = 5000

          described_class.new(
            source_id: source_id, destiny_id: destiny_id, amount: amount
          ).create

          expect(destiny_account.transfers.last.amount).to eq(5000)
        end
      end

      context 'quando o valor da transferência é menor ou igual a 0' do
        it 'NÃO cria transferências para nenhuma das contas' do
          source_account = create(:account)
          destiny_account = create(
            :account,
            account_number: 456,
            account_name: 'Silvio Santos',
            balance: 10_000,
            token: 'SiLvIoDuMMyToKeN'
          )

          source_id = source_account.account_number
          destiny_id = destiny_account.account_number
          amount = -500

          described_class.new(
            source_id: source_id, destiny_id: destiny_id, amount: amount
          ).create

          expect(source_account.transfers.last).to be_nil
          expect(destiny_account.transfers.last).to be_nil
        end
      end
    end

    context 'quando a conta de destino não é encontrada' do
      it 'NÃO cria transferências para nenhuma das contas' do
        source_account = create(:account)

        source_id = source_account.account_number
        destiny_id = 5568
        amount = 4000

        expect do
          described_class.new(
            source_id: source_id, destiny_id: destiny_id, amount: amount
          ).create
        end.not_to change { source_account.transfers.reload.count }
      end
    end

    context 'quando a conta de origem não é encontrada' do
      it 'NÃO cria transferências para nenhuma das contas' do
        destiny_account = create(:account)

        source_id = 8896
        destiny_id = destiny_account.account_number
        amount = 4000

        expect do
          described_class.new(
            source_id: source_id, destiny_id: destiny_id, amount: amount
          ).create
        end.not_to change { destiny_account.transfers.reload.count }
      end
    end
  end

  describe '.create' do
    it 'inicia o serviço, invoca e retorna o resultado de #create' do
      source_account = create(:account)
      destiny_account = create(
        :account,
        account_number: 456,
        account_name: 'Silvio Santos',
        balance: 10_000,
        token: 'SiLvIoDuMMyToKeN'
      )

      source_id = source_account.account_number
      destiny_id = destiny_account.account_number
      amount = 5000

      service = instance_double('TransferCreateService')
      transfer = instance_double('Transfer')

      expect(described_class).to receive(:new).with(
        source_id: source_id,
        destiny_id: destiny_id,
        amount: amount
      ).once.and_return(service)

      expect(service).to receive(:create).and_return(transfer)

      expect(
        described_class.create(
          source_id: source_id,
          destiny_id: destiny_id,
          amount: amount
        )
      ).to eq(transfer)
    end
  end
end

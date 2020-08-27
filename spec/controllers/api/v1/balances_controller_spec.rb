require 'rails_helper'

RSpec.describe Api::V1::BalancesController, type: :controller do
  describe 'GET /api/v1/balance' do
    context 'quando o usuário informa um ID válido' do
      it 'retorna status code 200' do
        account = create(:account, account_number: 123, initial_balance: 10_000)

        create_list(:transfer, 5, account: account, amount: 5000)
        create_list(:transfer, 3, account: account, amount: -2000)

        account_number = { account_number: 123 }

        create_balance_request(account_number)

        expect(response.status).to eq(200)
      end

      it 'exibe o saldo para o usuário' do
        account = create(:account, account_number: 123, initial_balance: 10_000)

        create_list(:transfer, 5, account: account, amount: 5000)
        create_list(:transfer, 3, account: account, amount: -2000)

        balance_params = { account_number: 123 }

        create_balance_request(balance_params)

        expect(JSON.parse(response.body)['balance']).to eq(29_000)
      end
    end

    context 'quando o usuário informa um ID inválido' do
      it 'retorna status code 404' do
        account = create(:account, account_number: 123, initial_balance: 10_000)

        create_list(:transfer, 5, account: account, amount: 5000)
        create_list(:transfer, 3, account: account, amount: -2000)

        account_number = { account_number: 456 }

        create_balance_request(account_number)

        expect(response.status).to eq(404)
      end

      it 'exibe mensagem de erro' do
        account = create(:account, account_number: 123, initial_balance: 10_000)

        create_list(:transfer, 5, account: account, amount: 5000)
        create_list(:transfer, 3, account: account, amount: -2000)

        account_number = { account_number: 456 }

        create_balance_request(account_number)

        message = 'Conta não encontrada!'

        expect(JSON.parse(response.body)['message']).to eq(message)
      end
    end
  end

  context 'quando usuário não informa o token de APIs' do
    it 'exibe mensagem de erro com erro de não autorizado' do
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'

      account_number = { account_number: 123 }

      get :index,
          params: account_number

      message = 'Requisição não autenticada!'

      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)['message']).to eq(message)
    end
  end

  def create_balance_request(account_number)
    request.headers['Content-Type'] = 'application/json'
    request.headers['Accept'] = 'application/json'
    request.headers['Authorization'] = 'testtoken'

    get :index,
        params: account_number
  end
end

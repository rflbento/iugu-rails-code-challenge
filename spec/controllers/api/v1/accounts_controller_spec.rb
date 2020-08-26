require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  describe 'POST /api/v1/accounts' do
    context 'quando usuário informa ID de conta ainda não utilizado' do
      it 'retorna status code 201' do
        account_params = {
          account_number: 123,
          account_name: 'Martinho da Vila',
          initial_balance: 10_000
        }

        create_account_request(account_params)

        expect(response.status).to eq(201)
      end

      it 'renderiza mensagem com os dados da conta' do
        account_params = {
          account_number: 123,
          account_name: 'Martinho da Vila',
          initial_balance: 10_000
        }

        create_account_request(account_params)

        expect(JSON.parse(response.body)['account_number']).to eq(123)
        expect(JSON.parse(response.body)['token']).not_to be_nil
      end
    end

    context 'quando usuário informa ID de já existente' do
      it 'retorna status code 422' do
        create(:account, account_number: 123)

        account_params = {
          account_number: 123,
          account_name: 'Martinho da Vila',
          initial_balance: 10_000
        }

        create_account_request(account_params)

        expect(response.status).to eq(422)
      end

      it 'renderiza mensagem de erro' do
        create(:account, account_number: 123)

        account_params = {
          account_number: 123,
          account_name: 'Martinho da Vila',
          initial_balance: 10_000
        }

        create_account_request(account_params)

        message = 'Este ID de conta já foi utilizado.'

        expect(JSON.parse(response.body)['message']).to eq(message)
      end
    end
  end

  def create_account_request(account_params)
    request.headers['Content-Type'] = 'application/json'
    request.headers['Accept'] = 'application/json'

    post :create,
         params: account_params
  end
end

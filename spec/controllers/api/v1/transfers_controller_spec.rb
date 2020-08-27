require 'rails_helper'

RSpec.describe Api::V1::TransfersController, type: :controller do
  describe 'POST /api/v1/transfers' do
    context 'quando os dados são válidos' do
      it 'retorna status code 201' do
        create(:account, account_number: 123, initial_balance: 10_000, token: 'FoO')
        create(:account, account_number: 456, initial_balance: 10_000, token: 'BaR')

        transfer_params = { source_id: 123, destiny_id: 456, amount: 5000 }

        create_transfer_request(transfer_params)

        expect(response.status).to eq(201)
      end

      it 'retorna mensagem de sucesso' do
        create(:account, account_number: 123, initial_balance: 10_000, token: 'FoO')
        create(:account, account_number: 456, initial_balance: 10_000, token: 'BaR')

        transfer_params = { source_id: 123, destiny_id: 456, amount: 5000 }

        create_transfer_request(transfer_params)

        message = 'Transferência realizada com sucesso!'

        expect(JSON.parse(response.body)['message']).to eq(message)
      end
    end

    context 'quando os dados são inválidos' do
      it 'com source account inválido, retorna mensagem de erro' do
        create(:account, account_number: 123, initial_balance: 10_000, token: 'FoO')
        create(:account, account_number: 456, initial_balance: 10_000, token: 'BaR')

        transfer_params = { source_id: 789, destiny_id: 456, amount: 5000 }

        create_transfer_request(transfer_params)

        message = 'Transferência rejeitada!'

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['message']).to eq(message)
      end

      it 'com destiny account inválido, retorna mensagem de erro' do
        create(:account, account_number: 123, initial_balance: 10_000, token: 'FoO')
        create(:account, account_number: 456, initial_balance: 10_000, token: 'BaR')

        transfer_params = { source_id: 123, destiny_id: 789, amount: 5000 }

        create_transfer_request(transfer_params)

        message = 'Transferência rejeitada!'

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['message']).to eq(message)
      end

      it 'com source inválido, retorna mensagem de erro' do
        create(:account, account_number: 123, initial_balance: 10_000, token: 'FoO')
        create(:account, account_number: 456, initial_balance: 10_000, token: 'BaR')

        transfer_params = { source_id: 123, destiny_id: 456, amount: 11_000 }

        create_transfer_request(transfer_params)

        message = 'Transferência rejeitada!'

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['message']).to eq(message)
      end
    end
  end

  context 'quando usuário não informa o token de APIs' do
    it 'exibe mensagem de erro com erro de não autorizado' do
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'

      transfer_params = { source_id: 123, destiny_id: 456, amount: 5000 }

      post :create,
           params: transfer_params

      message = 'Requisição não autenticada!'

      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)['message']).to eq(message)
    end
  end

  def create_transfer_request(transfer_params)
    request.headers['Content-Type'] = 'application/json'
    request.headers['Accept'] = 'application/json'
    request.headers['Authorization'] = 'testtoken'

    post :create,
         params: transfer_params
  end
end

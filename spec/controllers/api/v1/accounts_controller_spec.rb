require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  before do
    account_params = {
      account_number: 1994,
      account_name: 'John Doe',
      balance: 50_035
    }

    request.headers['Content-Type'] = 'application/json'
    request.headers['Accept'] = 'application/json'

    post :create,
         params: account_params
  end

  describe 'POST /api/v1/accounts' do
    it 'retorna status code 200' do
      expect(response.status).to eq(200)
    end

    context 'quando usuário informa ID de conta ainda não utilizado' do
      it 'renderiza mensagem com os dados' do
        expect(JSON.parse(response.body)['account_number']).to eq(1994)
        expect(JSON.parse(response.body)['token']).not_to be_nil
      end
    end

    context 'quando usuário informa ID de já existente' do
      before do
        create(:account)

        account_params = {
          account_number: 123,
          account_name: 'Bob Marley',
          balance: 30_053
        }

        request.headers['Content-Type'] = 'application/json'
        request.headers['Accept'] = 'application/json'

        post :create,
             params: account_params
      end

      it 'renderiza mensagem de erro' do
        expect(JSON.parse(response.body)['error']).to eq(
          'Este ID de conta já foi utilizado.'
        )
      end
    end
  end
end

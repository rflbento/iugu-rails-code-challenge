module Api
  module V1
    class BalancesController < ApplicationController
      def index
        account = Account.find_by(account_number: balance_params[:account_number])

        if account
          render json: { balance: account.balance },
                 status: :ok
        else
          render json: { message: 'Conta não encontrada!' },
                 status: :not_found
        end
      end

      private

      def balance_params
        params.permit(:account_number)
      end
    end
  end
end

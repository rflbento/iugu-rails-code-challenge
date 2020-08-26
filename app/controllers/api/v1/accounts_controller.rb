module Api
  module V1
    class AccountsController < ApplicationController
      def create
        service_response = AccountCreateService.new(
          account_number: account_params[:account_number],
          account_name: account_params[:account_name],
          initial_balance: account_params[:initial_balance]
        )

        if service_response.create
          render json: { message: 'Transferência realizada com sucesso!' },
                 status: :created
        else
          render json: { message: 'Transferência rejeitada!' },
                 status: :unprocessable_entity
        end
      end

      private

      def account_params
        params.require(:account).permit(
          :account_number, :account_name, :initial_balance
        )
      end
    end
  end
end

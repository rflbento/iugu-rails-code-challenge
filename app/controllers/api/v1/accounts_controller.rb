module Api
  module V1
    class AccountsController < ApplicationController
      def create
        account_number = account_params[:account_number]
        account_name = account_params[:account_name]
        balance = account_params[:balance]

        service_response = AccountCreateService.new(
          account_number: account_number,
          account_name: account_name,
          balance: balance
        ).create

        render json: service_response
      end

      private

      def account_params
        params.require(:account).permit(:account_number, :account_name, :balance)
      end
    end
  end
end

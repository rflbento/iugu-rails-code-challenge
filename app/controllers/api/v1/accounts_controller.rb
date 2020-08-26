module Api
  module V1
    class AccountsController < ApplicationController
      def create
        account = AccountCreateService.new(
          account_number: account_params[:account_number],
          account_name: account_params[:account_name],
          initial_balance: account_params[:initial_balance]
        ).create

        if account.persisted?
          render(
            json: {
              account_number: account.account_number,
              token: account.token
            },
            status: :created
          )
        else
          render json: { message: account.errors.messages.values.join(', ') },
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

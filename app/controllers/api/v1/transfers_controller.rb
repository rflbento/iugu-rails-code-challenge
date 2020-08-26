module Api
  module V1
    class TransfersController < ApplicationController
      def create
        transfer_service = TransferCreateService.new(
          source_id: transfer_params[:source_id],
          destiny_id: transfer_params[:destiny_id],
          amount: transfer_params[:amount]
        )

        if transfer_service.create
          render json: { message: 'Transferência realizada com sucesso!' },
                 status: :created
        else
          render json: { message: 'Transferência rejeitada!' },
                 status: :unprocessable_entity
        end
      end

      private

      def transfer_params
        params.permit(:source_id, :destiny_id, :amount)
      end
    end
  end
end

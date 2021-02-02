module Api
  module V1
    class UserUsagesController < ApplicationController
      def index
        user_usage = ClickIncrementService.new(request.original_url).call

        render(json: {
                 account_number: user_usage.number_of_clicks
              },
              status: :ok
            )
      end
    end
  end
end

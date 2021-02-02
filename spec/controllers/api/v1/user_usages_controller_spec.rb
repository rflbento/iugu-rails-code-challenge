require 'rails_helper'

RSpec.describe Api::V1::UserUsagesController, type: :controller do
  describe 'GET user_click' do
    context 'when user clicks on request' do
      it 'increment 1 on number_of_clicks' do
        create_user_usage_request

        expect(UserUsage.last.number_of_clicks).to eq 1
      end
    end
  end

  def create_user_usage_request
    request.headers['Content-Type'] = 'application/json'
    request.headers['Accept'] = 'application/json'

    get :index
  end
end

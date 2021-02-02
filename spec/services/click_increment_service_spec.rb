require 'rails_helper'

RSpec.describe ClickIncrementService do
  describe '.call' do
    describe 'when user send a request' do
      it 'increment the number of clicks' do
        path = 'https://foo.bar'
        user_usage = create(:user_usage)
        clicks = user_usage.number_of_clicks

        described_class.new(path).call

        final_result = user_usage.reload.number_of_clicks - clicks

        expect(final_result).to eq 1
      end
    end
  end
end

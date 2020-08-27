class ApplicationController < ActionController::API
  before_action :authenticate!

  private

  def authenticate!
    header_token = request.headers['Authorization']

    return unless api_token != header_token

    render json: { message: 'Requisição não autenticada!' },
           status: :unauthorized
  end

  def api_token
    YAML.load_file(Rails.root.join('config/api.yml'))[Rails.env]['API_TOKEN']
  end
end

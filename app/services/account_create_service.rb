class AccountCreateService
  ACCOUNT_NUMBER_ALREADY_EXISTS = 'Este ID de conta já foi utilizado.'.freeze

  attr_reader :account_number, :account_name, :initial_balance

  def initialize(account_number:, account_name:, initial_balance:)
    @account_number = account_number
    @account_name = account_name
    @initial_balance = initial_balance
  end

  def self.create(...)
    new(...).create
  end

  def create
    create_account
  end

  private

  def account
    @account ||= Account.find_by(account_number: account_number)
  end

  def create_account
    return error_response_body(ACCOUNT_NUMBER_ALREADY_EXISTS) if account.present?

    new_account = Account.new(
      account_number: unique_account_number,
      account_name: account_name,
      initial_balance: initial_balance,
      token: generate_token
    )

    new_account.save if new_account.valid?

    success_response_body(new_account)
  end

  def generate_token
    @generate_token ||= SecureRandom.hex
  end

  # FIXME: Se um usuario digitar como account_number 99999999999, o metodo
  # abaixo excedera o valor maximo permitido em banco
  def unique_account_number
    return account_number if account_number.present?

    max_account_number = Account.maximum(:account_number)

    max_account_number.nil? ? 1 : "#{max_account_number}1".to_i
  end

  def success_response_body(account)
    {
      account_number: account.account_number,
      token: account.token
    }
  end

  def error_response_body(message)
    {
      error: message
    }
  end
end

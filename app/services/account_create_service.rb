class AccountCreateService
  ACCOUNT_NUMBER_ALREADY_EXISTS = 'Este ID de conta já foi utilizado.'.freeze

  attr_reader :account_number, :account_name, :balance

  def initialize(account_number:, account_name:, balance:)
    @account_number = account_number
    @account_name = account_name
    @balance = balance
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
    return ACCOUNT_NUMBER_ALREADY_EXISTS if account.present?

    new_account = Account.new(
      account_number: unique_account_number,
      account_name: account_name,
      balance: balance,
      token: generate_token
    )

    new_account.save if new_account.valid?

    new_account
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
end

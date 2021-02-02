class ClickIncrementService
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def call
    increment_number_of_clicks
  end

  private

  def user_usage
    @user_usage ||= UserUsage.find_by(path: path)
  end

  def increment_number_of_clicks
    clicks_sum = user_usage.number_of_clicks + 1

    user_usage.update(number_of_clicks: clicks_sum)

    user_usage.reload
  end
end

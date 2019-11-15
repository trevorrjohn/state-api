class StateValidator
  attr_reader :error

  def initialize(state:, country:)
    @state = state
    @country = country
  end

  def valid?
    return http_failure unless response.success?
    return true if JSON.parse(response.body)&.dig("RestResponse", "result").present?

    @error = "State not valid for country"
    false
  end

  private

  attr_reader :state, :country

  def http_failure
    @error = "Could not validate state, please try again"
    false
  end

  def response
    @response ||= Faraday.get("http://groupkt.com/state/get/#{country}/#{state}")
  end
end

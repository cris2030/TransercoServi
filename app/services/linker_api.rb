class LinkerApi

  BASE_URL = "https://linkerone.com/API/General"

  def initialize
    @username = ENV["LINKER_USERNAME"]
    @password = ENV["LINKER_PASSWORD"]

    @connection = Faraday.new(
      headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
    )
  end

  def login
    response = @connection.post(
      "#{BASE_URL}/Session.svc/restService/Login"
    ) do |req|
      req.body = {
        User: @username,
        Password: @password,
        Session: {}
      }.to_json
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def session_data
    login[:Session]
  end

  def current_locations
    response = @connection.post(
      "#{BASE_URL}/Locations.svc/restService/CurrentLocation"
    ) do |req|
      req.body = {
        Session: session_data
      }.to_json
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def thermo_overview
    response = @connection.post(
      "#{BASE_URL}/Temperature.svc/restService/thermo_overview"
    ) do |req|
      req.body = {
        Session: session_data
      }.to_json
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def current_odometers
    response = @connection.post(
      "#{BASE_URL}/Odometer.svc/restService/GetCurrentOdometers"
    ) do |req|
      req.body = {
        Configuration: ENV["LINKER_CONFIGURATION"],
        Session: session_data
      }.to_json
    end

    JSON.parse(response.body, symbolize_names: true)
  end

end
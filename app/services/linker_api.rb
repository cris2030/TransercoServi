class LinkerApi

  BASE_URL = "https://linkerone.com/API/General"

  def initialize
    @username = ENV["LINKER_USERNAME"]
    @password = ENV["LINKER_PASSWORD"]

    @connection = Faraday.new(
      ssl: { verify: false },
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
      "#{BASE_URL}/Odometer.svc/restService/CurrentOdometers"
    ) do |req|
      req.body = {
        Session: session_data,
        Configuration: ENV["LINKER_CONFIGURATION"]
      }.to_json
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def odometros_por_unidad

    response = current_odometers

    return {} unless response[:Result] == "OK"

    odometers = response[:OdometersInfo] || []

    odometers.each_with_object({}) do |item, hash|

      next unless item[:UnitID]

      hash[item[:UnitID].to_s] = {
        odometro: item[:OdometerGps].to_f,
        motor_hours: item[:MotorHours].to_f
      }

    end
  end
  
  def visits(plates:, from:, to:)
    response = @connection.post(
      "#{BASE_URL}/Visits.svc/restService/GetVisits"
    ) do |req|
      req.body = {
        Plates: plates,
        From: from,
        To: to,
        Session: session_data
      }.to_json
    end

    JSON.parse(response.body, symbolize_names: true)
  end

end
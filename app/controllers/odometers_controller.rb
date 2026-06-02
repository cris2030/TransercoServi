class OdometersController < ApplicationController

  def index
    api = LinkerApi.new

    @odometers = api.current_odometers

    @odometers[:OdometersInfo] =
      @odometers[:OdometersInfo]&.sort_by do |item|
        item[:UnitName].to_s
      end
  end

end
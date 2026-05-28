class LocationsController < ApplicationController

  def index
    api = LinkerApi.new

    @locations = api.current_locations

    @locations[:CurrentLocations] =
      @locations[:CurrentLocations]&.sort_by do |item|
        item[:UnitName].to_s
      end
  end

end
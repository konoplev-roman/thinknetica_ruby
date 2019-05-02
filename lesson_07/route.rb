# frozen_string_literal: true

module Railway
  class Route
    include InstanceCounter

    ERROR_ROUTE = 'Only stations can be added to route'

    def initialize(start_station, end_station)
      @start_station = start_station
      @end_station = end_station

      @intermediate_stations = []

      validate!

      register_instance
    end

    def add_station(station)
      @intermediate_stations.push(station)
    end

    def delete_station(station)
      @intermediate_stations.delete(station)
    end

    def stations
      [@start_station, *@intermediate_stations, @end_station]
    end

    def to_s
      "from #{stations.first} to #{stations.last}"
    end

    def valid?
      validate!

      true
    rescue RailwayError
      false
    end

    private

    def validate!
      raise RailwayError, ERROR_ROUTE unless stations.all? { |s| s.is_a?(Station) }
    end
  end
end

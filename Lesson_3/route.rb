class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = []
    @stations << first_station << last_station
  end

  def add(station_name)
      if self.stations.include?(station_name) 
        puts "Такая станция уже есть в маршруте." 
      else
        self.stations.insert(-2, station_name)
      end 
  end

  def delete(station_name)  
    if self.stations.include?(station_name)
      if station_name == self.stations.first || station_name == self.stations.last
        puts "Нельзя удалять начальную или конечную станцию!"
      else
        self.stations.delete(station_name)
      end
    else
      puts "Такой станции нет в маршруте."
    end
  end

end
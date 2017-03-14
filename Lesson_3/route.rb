class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add(station)
    if stations.include?(station) 
      puts "Такая станция уже есть в маршруте." 
    else
      stations.insert(-2, station)
    end 
  end

  def delete(station)  
    if stations.include?(station)
      if station == stations.first || station == stations.last
        puts "Нельзя удалять начальную или конечную станцию!"
      else
        stations.delete(station)
        puts 'Станция удалена из маршрута!'
      end
    else
      puts "Такой станции нет в маршруте."
    end
  end

end
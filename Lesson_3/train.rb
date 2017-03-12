class Train
  attr_reader  :type, :number
  attr_accessor :speed, :wagons_count, :route, :current_station_index

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
    @current_station_index = 0
  end

  def add_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    if speed == 0 
      self.wagons_count += 1 
    else 
      puts "Изменения длины состава может осуществляться только если поезд не движется."
    end
  end

  def delete_wagon
    if speed == 0
      if wagons_count != 0
        self.wagons_count -= 1 
      else 
        puts "В составе пока нет вагонов, вы можете добавить их командой 'add_wagon'."
      end    
    else 
      puts "Изменения длины состава может осуществляться только если поезд не движется."
    end
  end

  def move_forward
    if current_station_index + 1 > route.stations.size-1 
      puts "Поезд не может переместиться туда."
    else
      route.stations[current_station_index].delete_train(self)
      self.current_station_index +=  1
      route.stations[current_station_index].add_train(self) 
    end 
  end

   def move_backward
    if current_station_index - 1 < 0
      puts "Поезд не может переместиться туда."
    else
      route.stations[current_station_index].delete_train(self)
      self.current_station_index -= 1
      route.stations[current_station_index].add_train(self) 
    end 
  end

  def next_station
    if  current_station_index == route.stations.size-1 
      route.stations[-1].name
    else
      route.stations[current_station_index +1]
    end
  end 

    def current_station
      route.stations[current_station_index]
    end

    def previous_station
      if current_station_index == 0
        route.stations[0]
      else
        route.stations[current_station_index-1]
      end
    end
end

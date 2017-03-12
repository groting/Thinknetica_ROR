class Train
  attr_reader  :type, :number
  attr_accessor :speed, :wagons_count, :route, :current_station

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
    @current_station = 0
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
      if wagons_count == 0
        puts "В составе пока нет вагонов, вы можете добавить их командой 'add_wagon'."
      else 
        self.wagons_count -= 1 
      end    
    else 
      puts "Изменения длины состава может осуществляться только если поезд не движется."
    end
  end

  def move_f
    arr_s = route.stations
    if current_station + 1 > arr_s.size-1 
      puts "Поезд не может переместиться туда."
    else
      arr_s[current_station].delete_train(self)
      self.current_station = current_station + 1
      arr_s[current_station].add_train(self) 
    end 
  end

   def move_b
    arr_s = route.stations
    if current_station - 1 < 0
      puts "Поезд не может переместиться туда."
    else
      arr_s[current_station].delete_train(self)
      self.current_station = current_station - 1
      arr_s[current_station].add_train(self) 
    end 
  end

  def n_station
    arr_s = route.stations
    if  current_station == arr_s.size-1 
      puts "Поезд достиг конечной станции: #{arr_s[-1].name}."
    else
      puts "Cледующая станция: #{arr_s[current_station+1].name}."
    end
  end 

    def c_station
      puts "Текущая станция: #{route.stations[current_station].name}."
    end

    def p_station
    arr_s = route.stations
      if current_station == 0
        puts "Поезд на начальной станции: #{arr_s[0].name}."
      else
        puts "Предыдущая станция: #{arr_s[current_station-1].name}."
      end
    end
end

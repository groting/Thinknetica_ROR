class Train
  attr_reader :speed
  attr_reader :lenght
  attr_reader :route
  attr_reader :type
  attr_reader :current_station
  attr_reader :number

  def initialize(number, type, lenght)
    @number = number
    @type = type
    @lenght = lenght
    @speed = 0
  end

  def route=(input)
    @route = input
    @current_station = self.route.stations.first
  end

  def add_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_lenght
    if self.speed == 0 
      self.lenght += 1 
    else 
      puts "Изменения длины состава может осуществляться только если поезд не движется."
    end
  end

  def reduce_lenght
    if self.speed == 0 
      self.lenght -= 1     
    else 
      puts "Изменения длины состава может осуществляться только если поезд не движется."
    end
  end

  def move(num)
    i = self.route.stations.index(current_station)
    if i + num > self.route.stations.size-1 || i + num < 0
      puts "Поезд не может переместиться туда."
    else
      self.current_station.delete_train(self)
      self.current_station = self.route.stations[i+num]
      self.current_station.add_train(self) 
    end 
  end

  def station
    arr_s = self.route.stations
    i = self.route.stations.index(current_station)
    if self.current_station == arr_s.first
      puts "Поезд на начальной станции: #{arr_s[0].name}. Cледующая станция: #{arr_s[1].name}."
    elsif  self.current_station == arr_s.last 
      puts "Предыдущая станция: #{arr_s[-2].name}. Поезд достиг конечной станции: #{arr_s[-1].name}."
    else
      puts "Предыдущая станция: #{arr_s[i-1].name}. Текущая станция: #{arr_s[i].name}. Cледующая станция: #{arr_s[i+1].name}."
    end
  end 
end

require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'station'
require_relative 'route'

class Main
  attr_reader :stations, :trains, :routes

  def run
    @stations = {}
    @trains = {}
    @routes = {}

    loop do

    puts 'Добро пожаловать в Поезда v 1.0'
    puts 'Список доступных команд:'
    puts '1) Создать станцию, Создать поезд, Создать маршрут.'
    puts '2) Изменить маршрут, Назначить маршрут поезду.' 
    puts '3) Добавить вагон, Отцепить вагон.'
    puts '4) Переместить поезд (вперед\назад) по маршруту.'
    puts '5) Просмотреть список станций, Просмотреть список поездов на станции.'
    puts '6) Выход.'

    case gets.chomp
    
    when 'Создать станцию'
      create_station
    when 'Создать поезд'
      create_train 
    when 'Создать маршрут'
      create_route
    when 'Изменить маршрут'
      change_route
    when 'Назначить маршрут поезду'
      set_train_route
    when 'Добавить вагон'
      attach_wagon
    when 'Удалить вагон'
      detach_wagon
    when 'Переместить поезд вперед по маршруту'
      train_go_forward
    when 'Переместить поезд назад по маршруту'
      train_go_backward
    when 'Просмотреть список станций'
      list_of_stations  
    when 'Просмотреть список поездов на станции'  
      trains_at_station
    when 'Выход'
      break
    else
      puts 'Такой команды нет.'
    end
  end
end

private

  def create_station
    puts 'Введите название станции:'
    station = gets.chomp
    if stations.key?(station) == false
      stations[station] = Station.new(station)
      puts 'Cтанция создана!'
    else
      puts 'Такая станция уже существует!'
    end
  end

  def create_train
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    unless trains.key?(train_number)
      puts 'Введите тип поезда(Грузовой\Пассажирский):'
      train_type = gets.chomp
      if train_type  == 'Грузовой'
        trains[train_number] = CargoTrain.new(train_number)
        puts 'Поезд создан!'
      elsif train_type == 'Пассажирский'
        trains[train_number] = PassengerTrain.new(train_number)
        puts 'Поезд создан!'
      else
        puts 'Тип поезда указан неверно!'
      end
    else
      puts 'Такой поезд уже существует!'
    end
  end

  def create_route
    puts 'Введите название маршрута:'
    route_name = gets.chomp
    unless routes.key?(route_name)
      puts 'Введите начальную станцию маршрута:'
      station = gets.chomp
      if stations.key?(station)
        route_first_station = stations[station]
        puts 'Введите конечную станцию маршрута:'
        station = gets.chomp
        if stations.key?(station)
          route_last_station = stations[station]
          routes[route_name] = Route.new(route_first_station, route_last_station)
          puts 'Маршрут создан!'
        else
          puts 'Такой станции не существует!'
        end
      else
        puts 'Такой станции не существует!'
      end
    else
      puts 'Такой маршрут уже существует!'
    end
  end

  def change_route
    puts 'Введите название маршрута:'
    route_name = gets.chomp
    if routes.key?(route_name)
      puts 'Введите действие (Добавить\Удалить):'
      action = gets.chomp
      if  action == 'Добавить'
        puts 'Введите название станции:'  
        station = gets.chomp
        if stations.key?(station)
          routes[route_name].add(stations[station])
          puts 'Станция добавлена к маршруту!'
        else
          puts 'Такой станции не существует!'
         end
      elsif action == 'Удалить'
        station = gets.chomp
        if stations.key?(station)
          routes[route_name].delete(stations[station])
          puts 'Станция удалена из маршрута!'
        else
          puts 'Такой станции не существует!'
        end
      else
        puts 'Такого действия не существует!'
      end
    else
      puts 'Такого маршрута не существует!'
    end
  end

  def set_train_route
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    if trains.key?(train_number)
      puts 'Введите название маршрута:'
      route_name = gets.chomp
      if routes.key?(route_name)
        trains[train_number].route = routes[route_name]
        puts 'Маршрут назначен!'
      else
        puts 'Такого маршрута не существует!'
      end
    else
      puts 'Такого поезда не существует!'
    end
  end

  def attach_wagon
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    if trains.key?(train_number)
      if trains[train_number].type == 'Cargo train'
        trains[train_number].add_wagon(CargoWagon.new(number_of_wagon += 1))
        puts 'Вагон добавлен!'
      else
        trains[train_number].add_wagon(PassengerWagon.new(number_of_wagon += 1))
        puts 'Вагон добавлен!'
      end
    else
      puts 'Такого поезда не существует!'
    end
  end

  def detach_wagon
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    if trains.key?(train_number)
      trains[train_number].delete_wagon
      puts 'Вагон удален!'
    else
      puts 'Такого поезда не существует!'
    end
  end

  def train_go_forward
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    if trains.key?(train_number) 
      trains[train_number].move_forward
      puts 'Поезд перемещен вперед!'
    else
      puts 'Такого поезда не существует!'
    end
  end

  def train_go_backward
    puts 'Введите номер поезда:'
    train_number = gets.chomp.to_i
    if trains.key?(train_number) 
      trains[train_number].move_backward
      puts 'Поезд перемещен назад!'
    else
      puts 'Такого поезда не существует!'
    end
  end

  def list_of_stations
    if stations.any?
      puts stations.keys
    else
      puts 'Вы пока не создали ни одной станции!'
    end
  end

  def trains_at_station
    puts 'Введите название стании:'
    station = gets.chomp
    if stations.key?(station)
      stations[station].trains.each {|train| puts train.number}
    else
      puts 'Такой станции не существует!'
    end
  end
end

app = Main.new
app.run
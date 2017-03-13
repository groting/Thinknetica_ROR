require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'station'
require_relative 'route'

stations = {}
trains = {}
routes = {}

number_of_wagon = 0

loop do

  puts 'Добро пожаловать в Поезда v 1.0'
  puts 'Список доступных команд:'
  puts '1) Создать станцию, Создать поезд, Создать маршрут.'
  puts '2) Изменить маршрут, Назначить маршрут поезду.' 
  puts '3) Добавить вагон, Отцепить вагон.'
  puts '4) Переместить поезд (вперед\назад) по маршруту.'
  puts '5) Просмотреть список станций, Просмотреть список поездов на станции.'
  puts '6) Выход.'

    case user_answer = gets.chomp
    
    when 'Создать станцию'
      puts 'Введите название станции:'
      if stations.key?(station = gets.chomp) == false
        stations[station] = Station.new(station)
        puts 'Cтанция создана!'
      else
        puts 'Такая станция уже существует!'
      end
    
    when 'Создать поезд'
      puts 'Введите номер поезда:'
      if trains.key?(train_number = gets.chomp.to_i) == false
        puts 'Введите тип поезда(Грузовой\Пассажирский):'
        train_type = gets.chomp
          if train_type  == 'Грузовой'
            trains[train_number] = Cargo_train.new(train_number)
            puts 'Поезд создан!'
          elsif train_type == 'Пассажирский'
            trains[train_number] = Passenger_train.new(train_number)
            puts 'Поезд создан!'
          else
            puts 'Тип поезда указан неверно!'
          end
      else
        puts 'Такой поезд уже существует!'
      end

    when 'Создать маршрут'
      puts 'Введите название маршрута:'
      if routes.key?(route_name = gets.chomp) == false
        puts 'Введите начальную станцию маршрута:'
        if stations.key?(station = gets.chomp)
          route_first_station = stations[station]
          puts 'Введите конечную станцию маршрута:'
          if stations.key?(station = gets.chomp)
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

    when 'Изменить маршрут'
      puts 'Введите название маршрута:'
      if routes.key?(route_name = gets.chomp)
        puts 'Введите действие (Добавить\Удалить):'
        action = gets.chomp
        if  action == 'Добавить'
            puts 'Введите название станции:'  
            if stations.key?(station = gets.chomp)
              routes[route_name].add(stations[station])
              puts 'Станция добавлена к маршруту!'
            else
              puts 'Такой станции не существует!'
            end
          elsif action == 'Удалить'
            if stations.key?(station = gets.chomp)
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

    when 'Назначить маршрут поезду'
      puts 'Введите номер поезда:'
      if trains.key?(train_number = gets.chomp.to_i)
        puts 'Введите название маршрута:'
        if routes.key?(route_name = gets.chomp)
          trains[train_number].route = routes[route_name]
          puts 'Маршрут назначен!'
        else
          puts 'Такого маршрута не существует!'
        end
      else
        puts 'Такого поезда не существует!'
      end

    when 'Добавить вагон'
      puts 'Введите номер поезда:'
      if trains.key?(train_number = gets.chomp.to_i)
        if trains[train_number].type == 'Cargo train'
          trains[train_number].add_wagon(Cargo_wagon.new(number_of_wagon += 1))
          puts 'Вагон добавлен!'
        else
          trains[train_number].add_wagon(Passenger_wagon.new(number_of_wagon += 1))
          puts 'Вагон добавлен!'
        end
      else
        puts 'Такого поезда не существует!'
      end

    when 'Удалить вагон'
      puts 'Введите номер поезда:'
      if trains.key?(train_number = gets.chomp.to_i)
        trains[train_number].delete_wagon
        puts 'Вагон удален!'
      else
        puts 'Такого поезда не существует!'
      end

    when 'Переместить поезд вперед по маршруту'
      puts 'Введите номер поезда:'
      if trains.key?(train_number = gets.chomp.to_i) 
        trains[train_number].move_forward
        puts 'Поезд перемещен вперед!'
      else
        puts 'Такого поезда не существует!'
      end

    when 'Переместить поезд назад по маршруту'
      puts 'Введите номер поезда:'
      if trains.key?(train_number = gets.chomp.to_i) 
        trains[train_number].move_backward
        puts 'Поезд перемещен назад!'
      else
        puts 'Такого поезда не существует!'
      end

    when 'Просмотреть список станций'
      if stations.any?
        puts stations.keys
      else
        puts 'Вы пока не создали ни одной станции!'
      end

    when 'Просмотреть список поездов на станции'
      puts 'Введите название стании:'
      if stations.key?(station = gets.chomp)
        stations[station].trains.each {|train| puts train.number}
      else
        puts 'Такой станции не существует!'
      end

    when 'Выход'
      break

    else
      puts 'Такой команды нет.'
    end
end


require_relative 'station'
require_relative 'route'
require_relative 'train_int'

class Main

  include TrainInterface

  def run
    loop do
      system('clear')

      puts 'Добро пожаловать в Поезда v 1.4'
      puts 'Список доступных команд:'
      puts '1) Создать станцию(а), Создать поезд(б), Создать маршрут(в).'
      puts '2) Изменить маршрут(г), Назначить маршрут поезду(д).'
      puts '3) Добавить вагон(е), Отцепить вагон(ж).'
      puts '4) Переместить поезд (вперед(з)\назад(и)) по маршруту.'
      puts '5) Просмотреть список станций(к), Просмотреть список поездов на станции(л).'
      puts '6) Просмотреть список вагонов поезда(м), Занять место в вагоне(н).'
      puts '7) Выход.'

      options =
        { 'а' => :create_station,    'б' => :create_train,      'в' => :create_route,
          'г' => :change_route,      'д' => :set_train_route,   'е' => :attach_wagon,
          'ж' => :detach_wagon,      'з' => :train_go_forward,  'и' => :train_go_backward,
          'к' => :list_of_stations,  'л' => :trains_at_station, 'м' => :wagons_in_train,
          'н' => :occupy_wagon }

      user_answer = gets.chomp
      system('clear')
      return if user_answer == 'Выход'
      raise 'Такой команды нет.' unless options.key?(user_answer)
      send(options[user_answer])
      STDIN.getc
    end
  #rescue StandardError => e
    #puts "Произошла ошибка: #{e.message} Повторите попытку."
    #STDIN.getc
    #retry
  end

  private

  def create_station
    set_station_name
    raise 'Такая станция уже существует!' if Station.all.key?(station)
    Station.new(station)
    puts 'Cтанция создана!'
  end

  def create_route
    set_route_name
    raise 'Такой маршрут уже существует!' if Route.all.key?(route_name)
    print 'Начальная станция. '
    station_exist!
    route_first_station = Station.all[station]
    print 'Конечная станция. '
    station_exist!
    route_last_station = Station.all[station]
    Route.new(route_first_station, route_last_station, route_name)
    puts 'Маршрут создан!'
  end

  def change_route
    route_exist!
    puts 'Введите действие (Добавить(а)\Удалить(б)):'
    action = gets.chomp
    raise 'Такого действия не существует!' unless %w(а б).include?(action)
    station_exist!
    if action == 'а'
      Route.all[route_name].add(Station.all[station])
    else
      Route.all[route_name].delete(Station.all[station])
    end
  end

  def list_of_stations
    raise 'Вы пока не создали ни одной станции!' if Station.all.empty?
    puts Station.all.keys
  end

  def trains_at_station
    station_exist!
    raise 'На станции нет поездов!' if Station.all[station].trains.empty?
    Station.all[station].each_train { |train| puts "Номер поезда:#{train.number} Тип: #{train.type} Количество вагонов:#{train.wagons.size}" }
  end

  def set_route_name
    puts 'Введите название маршрута поезда:'
    @route_name = gets.chomp
  end

  def set_station_name
    puts 'Введите название станции:'
    @station = gets.chomp
  end

  def route_exist!
    set_route_name
    raise 'Такого маршрута не существует!' unless Route.all.key?(route_name)
  end

  def station_exist!
    set_station_name
    raise 'Такой станции не существует!' unless Station.all.key?(station)
  end

  attr_accessor :route_name, :station
end

app = Main.new
app.run

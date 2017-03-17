require_relative 'producer_name'

class Wagon
  include ProducerName

  attr_reader :capacity, :free_space, :number

  def initialize(capacity)
    @capacity = capacity
    validate!
    @free_space = capacity
    @number = rand(1..9999)
  end

  def valide?
    validate!
  rescue
    false
  end

  def occupied
    capacity - free_space
  end

  protected 
  attr_writer :free_space

  def validate!
    raise "Значение вместимости должно быть больше нуля!" if !capacity.kind_of?(Numeric) || capacity <= 0
    true
  end
end
require_relative 'producer_name'
require_relative 'validation'

class Wagon
  include ProducerName
  include Validation

  validate('capacity', 'type', Numeric) 

  attr_reader :capacity, :free_space, :number

  def initialize(capacity)
    @capacity = capacity
    validate!
    @free_space = capacity
    @number = rand(1..9999)
  end

  def occupied
    capacity - free_space
  end

  protected

  attr_writer :free_space
end

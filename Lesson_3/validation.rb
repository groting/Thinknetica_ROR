module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(*args)
      @validations ||= []
      @validations << args
    end
  end

  module InstanceMethods
    def validate!
      options = 
      {'presence' => :validate_presence, 'format' => :validate_format, 'type' =>:validate_type}
     self.class.validations.each do |name, validation_type, expression|
        validation_variable = instance_variable_get("@#{name}".to_sym) 
        send(options[validation_type], validation_variable, expression)
      end
      true
    end

    def valide?
      validate!
    rescue
      false
    end

    private

    def validate_presence(name,*)
      puts name
      raise 'Этот атрибут не может быть пустым!' if name.nil? || name.empty?
    end

    def validate_format(name, format)
      raise 'Этот атрибут не соответствует формату!' if name !~ format
    end

    def validate_type(name,type)
      raise "Этот атрибут должен принадлежать классу #{type}!" unless name.is_a?(type)
    end
  end
end

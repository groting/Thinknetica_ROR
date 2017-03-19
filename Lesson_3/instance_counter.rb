module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :count_instances
  end

  module InstanceMethods
    private

    def register_instance
      self.class.count_instances ||= 0
      self.class.count_instances += 1
    end
  end
end

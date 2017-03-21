module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      variable_name = "@#{name}".to_sym
      history = []
      history_var_name = "@#{name}_history".to_sym
      define_method(name.to_sym) {instance_variable_get(variable_name)}
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(variable_name, value)
        instance_variable_set(history_var_name, history << value)
      end
      define_method("#{name}_history".to_sym) {instance_variable_get(history_var_name)}
    end
  end

  def strong_attr_accessor(name, type)
    variable_name = "@#{name}".to_sym
    define_method(name.to_sym) {instance_variable_get(variable_name)}
    define_method("#{name}=".to_sym) do |value|
      raise TypeError, 'Неверный тип данных!' unless value.is_a?(type)
      instance_variable_set(variable_name, value)
    end
  end
end
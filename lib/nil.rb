module Configuratrilla
  class Nil
    def initialize(parent, method)
      @parent = parent
      @previous_method = method
    end

    def to_ary(*args)
      nil
    end

    def to_a(*args)
      nil
    end

    def method_missing(method_id, *args, &block)
      new_conf = @parent.class.new(@parent)
      values = @parent.instance_variable_get(:@values)
      values.merge!(@previous_method => new_conf)
      if block_given?
        new_conf.instance_eval(&block)
      else
        new_conf.public_send(method_id, *args)
      end
    end
  end
end
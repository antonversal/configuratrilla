module Configuratrilla
  class Nil
    def initialize(parent, method)
      @parent = parent
      @previous_method = method
    end

    def inspect
      self.to_s
    end

    %w{nil? rationalize to_a to_c to_f to_i to_r | & ^ == != ! === eql? equal? to_ary}.each do |m|
      define_method m do |*args|
        nil.send(m,*args)
      end
    end

    def method_missing(method_id, *args, &block)
      new_conf = @parent.class.new(@parent)
      values = @parent.instance_variable_get(:@values)
      values.merge!(@previous_method => new_conf)
      new_conf.public_send(method_id, *args, &block)
    end
  end
end
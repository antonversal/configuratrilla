module Configuratrilla
  class Config

    def initialize(parent = nil, &block)
      @parent = parent
      @values = {}
      instance_eval(&block) if block_given?
    end

    def to_ary(*args)
      raise NoMethodError
    end

    def to_hash
      @values.inject({}) do |memo,(k,v)|
        memo.merge(k => v.is_a?(Configuratrilla::Config) ? v.to_hash : v)
      end
    end

    def method_missing(method_id, *args, &block)
      raise "Too many arguments" if args.size > 1
      if method_id.to_s[-1, 1] == "="
        @values.merge!({method_id.to_s[0..-2] => args.first})
        args.first
      elsif args.size == 1
        @values.merge!({method_id.to_s => args.first})
        args.first
      elsif block_given?
        new_conf = self.class.new(self)
        @values.merge!({method_id.to_s => new_conf})
        new_conf.instance_eval(&block)
      elsif @values.keys.include? method_id.to_s
        @values[method_id.to_s]
      else
        Nil.new(self, method_id.to_s)
      end
    end
  end
end
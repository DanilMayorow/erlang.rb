module ErlangRuby
  module Terms
    class Tuple
      attr_accessor :arity, :value
      def initialize(arity, value)
        self.arity = arity
        self.value = value
      end

      def decode
        value.map do |term|
          term.decode
        end
      end

      def self.build(data)
        tuple_data = data.dup
        arity, rest_of_data = Utils.read_first(tuple_data)
        content = []
        arity.times.map do
          term, rest_of_data = Terms.build(rest_of_data)
          content << term
        end
        tuple = self.new(arity, content)
        [tuple, rest_of_data]
      end
    end
  end
end

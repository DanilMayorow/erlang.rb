module ErlangRuby
  module Terms
    class Array
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
        array_data = data.dup
        arity, rest_of_data = Utils.read_first(array_data)
        content = []
        arity.times.map do
          term, rest_of_data = Terms.build(rest_of_data)
          content << term
        end
        array = self.new(arity, content)
        [array, rest_of_data]
      end
    end
  end
end

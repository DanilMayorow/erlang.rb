module ErlangRuby
  module Terms
    class Hashe
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
        puts data
      end
    end
  end
end

module ErlangRuby
  module Terms
    class Number
      attr_accessor :value
      def initialize(content)
        self.value = content
      end

      def decode
        value.to_sym
      end

      def self.build(data)
        puts data
      end
    end
  end
end
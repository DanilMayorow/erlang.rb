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
        content = []

        tag, rest_data = Utils.read_first(array_data)
        case tag
        when NIL
          return [[], rest_data]
        when S_TUPLE
          arity, rest_data = Utils.read_first(rest_data)
          arity.times.map do
            term, rest_data = Terms.build(rest_data)
            content << term
          end
        when L_TUPLE, LIST
          arity = rest_data.byteslice(0, 4).unpack("N").first
          rest_data = rest_data.byteslice(4..-1)
          arity.times.map do
            term, rest_data = Terms.build(rest_data)
            content << term
          end
          if tag == LIST
            tail, rest_data = Utils.read_first(rest_data)
            if tail != NIL
              raise "Incorrect tail"
            else
              array = self.new(arity, content)
              return [array, rest_data]
            end
          end
          array = self.new(arity, content)
          [array, rest_data]
        end
      end
    end
  end
end

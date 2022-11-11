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
        map = Hash.new
        dup_data = data.dup
        tag, rest_of_data = Utils.read_first(dup_data)

        unless tag == MAP
          raise "It's not map"
        end

        arity = rest_of_data.byteslice(0, 4).unpack("N").first
        rest_of_data = rest_of_data.byteslice(4..-1)
        arity.times.map do
          key, rest_of_data = Terms.build(rest_of_data)
          value, rest_of_data = Terms.build(rest_of_data)
          map[key.decode] = value.decode
        end
        hash = self.new(arity, map)
        [hash, rest_of_data]
      end
    end
  end
end

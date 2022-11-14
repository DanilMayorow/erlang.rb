module ErlangRuby
  module Terms
    class String
      attr_accessor :value
      def initialize(content)
        self.value = content
      end

      def decode
        value
      end

      def self.build(data)
        dup_data = data.dup
        tag, rest_of_data = Utils.read_first(dup_data)
        case tag
        when STRING
          length = rest_of_data.byteslice(0, 2).unpack("n").first
          content = rest_of_data.byteslice(2, length).unpack("A*").first
          str = self.new(content)
          [str, rest_of_data[(length+2)..-1]]
        when BINARY
          length = rest_of_data.byteslice(0, 4).unpack("N").first
          content = rest_of_data.byteslice(4, length).unpack("A*").first
          str = self.new(content)
          [str, rest_of_data[(length+4)..-1]]
        else
          raise "Undefined type of atom"
	end
      end
    end
  end
end

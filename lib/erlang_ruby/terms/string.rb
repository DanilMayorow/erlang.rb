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
          length = dup_data.byteslice(0, 2).unpack("n").first
          content = dup_data.byteslice(2, length).unpack("C*").first
        when BINARY
          length = dup_data.byteslice(0, 4).unpack("N").first
          content = dup_data.byteslice(4, length).unpack("A*").first
        else
          raise "Undefined type of atom"
        end

        str = self.new(content)
        [str, rest_of_data[length..-1]]
      end
    end
  end
end
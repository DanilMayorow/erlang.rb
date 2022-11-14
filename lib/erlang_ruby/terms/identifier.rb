module ErlangRuby
  module Terms
    class Identifier
      attr_accessor :value
      def initialize(content)
        self.value = content
      end

      #Extend function to enable booleans and nil
      def decode
        value
      end

      def self.build(data)
        dup_data = data.dup
        tag, rest_of_data = Utils.read_first(dup_data)
        if tag == NEW_REF || tag == NEWER_REF
          len, rest_of_data = self.get_data(rest_of_data, 2)
        end
        node, rest_of_data = Terms::Symbol.build(rest_of_data)
        case tag
        when PORT, NEW_PORT, PID, NEW_PID, REF
          _, rest_of_data = self.get_data(rest_of_data, 4)
          if tag == PID || tag == NEW_PID
            _ , rest_of_data = self.get_data(rest_of_data, 4)
          end
          case tag
          when PORT, PID, REF
            _ , rest_of_data = self.get_data(rest_of_data, 1)
          else
            _ , rest_of_data = self.get_data(rest_of_data, 4)
          end
        when NEW_REF, NEWER_REF
          if tag == NEW_REF
            _ , rest_of_data = self.get_data(rest_of_data, 1)
          else
            _ , rest_of_data = self.get_data(rest_of_data, 4)
          end
          _ , rest_of_data = self.get_data(rest_of_data, 4*len)
        else
          raise "Undefined type of atom"
        end

        id = self.new(node.decode)
        [id, rest_of_data]
      end

      def self.get_data(data, len)
	case len
        when 1
          [data.byteslice(0, 1).unpack("C").first, data[1..-1]]
        when 2
          [data.byteslice(0, 2).unpack("n").first, data[2..-1]]
        when 4
          [data.byteslice(0, 4).unpack("N").first, data[4..-1]]
        else
          [data.byteslice(0, len).unpack("C*").first, data[len..-1]]
        end
      end

    end
  end
end

module ErlangRuby
  module Terms
    class Symbol
      attr_accessor :value
      def initialize(content)
        self.value = content
      end

      #Extend function to enable booleans and nil
      def decode
        case value
        when "true"
          return true
        when "false"
          return false
        when "undefined"
          return nil
        else
          value.to_sym
        end
      end

      def self.build(data)
        dup_data = data.dup
        tag, rest_of_data = Utils.read_first(dup_data)
        case tag
        when ATOM, ATOM_UTF8
          shift = 2
          length = rest_of_data.byteslice(0, 2).unpack("n").first
          content = rest_of_data.byteslice(2, length).unpack("A*").first
        when S_ATOM, S_ATOM_UTF8
          shift = 1
          length = rest_of_data.byteslice(0, 1).unpack("C").first
          content = rest_of_data.byteslice(1, length).unpack("A*").first
        else
          raise "Undefined type of atom"
        end

        atom = self.new(content)
        [atom, rest_of_data[(length + shift)..-1]]
      end
    end
  end
end

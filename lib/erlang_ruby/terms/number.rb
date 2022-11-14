module ErlangRuby
  module Terms
    class Number
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
        when S_INTEGER
          content = rest_of_data.byteslice(0,1).unpack("C").first
          int = self.new(content)
          return [int, rest_of_data[1..-1]]
        when INTEGER
          content = rest_of_data.byteslice(0,4).unpack("N").first
          content -= 0x100000000 if content > 0x7fffffff
          int = self.new(content)
          return [int, rest_of_data[4..-1]]
        when S_BIG, L_BIG
          length = 0
          sign = 0
          if tag == S_BIG
            length, sign = rest_of_data.byteslice(0,2).unpack("CC")
            rest_of_data = rest_of_data[2..-1]
          elsif L_BIG
            length, sign = rest_of_data.byteslice(0,5).unpack("NC")
            rest_of_data = rest_of_data[5..-1]
          end
          num = 0
          if length > 0
            for i in rest_of_data[0,length].unpack("C*").reverse!
              num = (num << 8) | i
            end
            num = -num if sign != 0
          end
          bignum = self.new(num)
          [bignum, rest_of_data[length..-1]]
        when NEW_FLOAT
          content = rest_of_data.byteslice(0,8).unpack("G").first
          float = self.new(content)
          [float, rest_of_data[8..-1]]
        else
          raise "Undefined type of number"
        end
      end
    end
  end
end
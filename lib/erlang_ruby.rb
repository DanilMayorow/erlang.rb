require "erlang_ruby/version"

module ErlangRuby
  class Decoder
    def self.perform(data)
      version_number = data.byteslice(0, 1).unpack("C").first
      raise "Cannot understand this version" if version_number != 131
      
      tag = data.byteslice(1, 1).unpack("C").first
      case tag
      when 100
        Terms::Atom.new(data.byteslice(2..-1))
      end
    end
  end
end

module ErlangRuby
  class Version
  end
end

module ErlangRuby
  module Terms
    class Atom
      def initialize(data)
        @data = data.dup
        @length = @data.byteslice(0, 2).unpack("n").first
        @content = @data.byteslice(2, @length).unpack("A#{@length}").first
      end

      def decode
        @content.to_sym
      end
    end
  end
end

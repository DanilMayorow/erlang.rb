module ErlangRuby
  module Terms
    class Atom
      attr_accessor :value
      def initialize(content)
        self.value = content
      end

      def decode
        value.to_sym
      end

      def self.build(data)
        atom_data = data.dup
        length = atom_data.byteslice(0, 2).unpack("n").first
        content = atom_data.byteslice(2, length).unpack("A*").first
        atom = self.new(content)
        [atom, atom_data[(length + 2)..-1]]
      end
    end
  end
end

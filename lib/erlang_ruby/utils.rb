module ErlangRuby
  module Utils
    def self.read_first(data, type = "C")
      first = data.byteslice(0, 1).unpack(type).first
      rest = data.byteslice(1..-1)
      [first, rest]
    end
  end
end

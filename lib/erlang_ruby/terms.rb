require "erlang_ruby/terms/atom"
require "erlang_ruby/terms/tuple"

module ErlangRuby
  module Terms
    ATOM = 100
    TUPLE = 104

    def self.build(data)
      term_data = data.dup
      tag, rest_of_data = Utils.read_first(term_data)
      case tag
      when ATOM
        Terms::Atom.build(rest_of_data)
      when TUPLE
        Terms::Tuple.build(rest_of_data)
      end
    end
  end
end

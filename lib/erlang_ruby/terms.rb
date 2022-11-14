require_relative "terms/symbol.rb"
require_relative "terms/array.rb"
require_relative 'terms/string.rb'
require_relative 'terms/hash.rb'
require_relative 'terms/number.rb'
require_relative 'terms/identifier.rb'

module ErlangRuby
  module Terms
    # Data type codes for ETF (External Term Format)
    NEW_FLOAT       = 70
    BIT_BINARY      = 77
    ATOM_CACHE_REF  = 82
    NEW_PID         = 88
    NEW_PORT        = 89
    NEWER_REF       = 90

    S_INTEGER       = 97
    INTEGER         = 98
    FLOAT           = 99   # depricated
    ATOM            = 100
    REF             = 101  # depricated. see: ERL_NEW_REF
    PORT            = 102
    PID             = 103
    S_TUPLE         = 104
    L_TUPLE         = 105
    NIL             = 106
    STRING          = 107
    LIST            = 108
    BINARY          = 109
    S_BIG           = 110
    L_BIG           = 111
    NEW_FUN	        = 112  # refused
    EXPORT          = 113  # refused
    NEW_REF         = 114
    S_ATOM          = 115
    MAP             = 116
    FUN	            = 117  # removed
    ATOM_UTF8       = 118
    S_ATOM_UTF8     = 119
    
    def self.build(data)
      term_data = data.dup
      tag, _ = Utils.read_first(term_data)
      case tag
      when ATOM, S_ATOM, ATOM_UTF8, S_ATOM_UTF8
        Terms::Symbol.build(term_data)
      when PORT, NEW_PORT, PID, NEW_PID,  REF, NEW_REF, NEWER_REF
        Terms::Identifier.build(term_data)
      when S_TUPLE, L_TUPLE, LIST, NIL
        Terms::Array.build(term_data)
      when INTEGER, S_INTEGER, S_BIG, L_BIG, NEW_FLOAT
        Terms::Number.build(term_data)
      when STRING, BINARY
        Terms::String.build(term_data)
      when MAP
        Terms::Hash.build(term_data)
      else
        raise "Undefined type"
      end
    end
  end
end
